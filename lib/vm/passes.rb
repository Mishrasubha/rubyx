module Vm
  # Passes, or BlockPasses, could have been procs that just get each block passed.
  # Instead they are proper objects in case they want to save state.
  # The idea is 
  # - reduce noise in the main code by having this code seperately (aspect/concern style)
  # - abstract the iteration
  # - allow not yet written code to hook in
  
  class RemoveStubs
    def run block
      block.codes.dup.each_with_index do |kode , index|
        next unless kode.is_a? StackInstruction
        if kode.regiters.empty?
          block.codes.delete(kode) 
          puts "deleted stack instruction in #{b.name}"
        end
      end
    end
  end

  # Operators eg a + b , must assign their result somewhere and as such create temporary variables.
  # but if code is c = a + b , the generated instructions would be more like tmp = a + b ; c = tmp
  # SO if there is an move instruction just after a logic instruction where the result of the logic
  # instruction is moved straight away, we can undo that mess and remove one instruction.
  class LogicMoveReduction
    def run block
      org = block.codes.dup
      org.each_with_index do |kode , index|
        n = org[index+1]
        next if n.nil?
        next unless kode.is_a? LogicInstruction
        next unless n.is_a? MoveInstruction
        if kode.result == n.from
          kode.result = n.to
          block.codes.delete(n)
        end
      end
    end
  end

  # Sometimes there are double moves ie mov a, b and mov b , c . We reduce that to move a , c 
  # (but don't check if that improves register allocation. Yet ?) 
  class MoveMoveReduction
    def run block
      org = block.codes.dup
      org.each_with_index do |kode , index|
        n = org[index+1]
        next if n.nil?
        next unless kode.is_a? MoveInstruction
        next unless n.is_a? MoveInstruction
        if kode.to == n.from
          kode.to = n.to
          block.codes.delete(n)
        end
      end
    end
  end

  # We insert push/pops as dummies to fill them later in CallSaving
  # as we can not know ahead of time which locals wil be live in the code to come
  # and also we don't want to "guess" later where the push/pops should be
  
  # Here we check which registers need saving and add them
  # Or sometimes just remove the push/pops, when no locals needed saving
  class SaveLocals
    def run block
      unless block.function
        puts "No function for #{block.name}"
      end
      push = block.call_block?
      return unless push
      locals = block.function.locals_at block
      pop = block.next.codes.first
      if(locals.empty?)
        puts "Empty #{block.name}"
        block.codes.delete(push)
        block.next.codes.delete(pop)
      else
        puts "PUSH #{push}"
        push.set_registers(locals)
        puts "POP #{pop}"
        pop.set_registers(locals)
      end
    end
  end
end
