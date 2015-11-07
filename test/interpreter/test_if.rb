require_relative "helper"

class AddTest < MiniTest::Test
  include Ticker
  include AST::Sexp

  def test_if
    @string_input = <<HERE
class Object
  int itest(int n)
    if_zero( n - 12)
      "then".putstring()
    else
      "else".putstring()
    end
  end

  int main()
    itest(20)
  end
end
HERE
      machine = Register.machine.boot
      syntax  = Parser::Salama.new.parse_with_debug(@string_input)
      parts = Parser::Transform.new.apply(syntax)
      #puts parts.inspect
      Soml.compile( parts )
      machine.collect
      @interpreter = Interpreter::Interpreter.new
      @interpreter.start Register.machine.init
      #show_ticks # get output of what is
      ["Branch","Label","LoadConstant","GetSlot","SetSlot",
     "LoadConstant","SetSlot","FunctionCall","Label","GetSlot",
     "GetSlot","SetSlot","LoadConstant","SetSlot","LoadConstant",
     "SetSlot","LoadConstant","SetSlot","LoadConstant","SetSlot",
     "RegisterTransfer","FunctionCall","Label","GetSlot","LoadConstant",
     "OperatorInstruction","IsZero","GetSlot","LoadConstant","SetSlot",
     "LoadConstant","SetSlot","LoadConstant","SetSlot","LoadConstant",
     "SetSlot","RegisterTransfer","FunctionCall","Label","GetSlot",
     "RegisterTransfer","Syscall","RegisterTransfer","RegisterTransfer","SetSlot",
     "Label","FunctionReturn","RegisterTransfer","GetSlot","GetSlot",
     "Branch","Label","Label","FunctionReturn","RegisterTransfer",
     "GetSlot","GetSlot","Label","FunctionReturn","RegisterTransfer",
     "Syscall","NilClass"].each_with_index do |name , index|
      got = ticks(1)
      assert got.class.name.index(name) , "Wrong class for #{index+1}, expect #{name} , got #{got}"
    end
    #puts @interpreter.block.inspect

  end
end
