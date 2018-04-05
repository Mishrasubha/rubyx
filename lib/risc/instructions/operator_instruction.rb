module Risc

  # Destructive operator instructions on the two registers given
  #
  # left = left OP right
  #
  # With OP being the normal logical and mathematical operations provided by
  # cpus. Ie  "+" , "-", ">>", "<<", "*", "&", "|"
  #
  class OperatorInstruction < Instruction
    def initialize( source , operator , left , right )
      super(source)
      @operator = operator
      raise "unsuported operator :#{operator}:" unless [:+, :-, :>>, :<<, :*, :&, :|, :==].include?(operator)
      @left = left
      @right = right
      raise "Not register #{left}" unless RiscValue.look_like_reg(left)
      raise "Not register #{right}" unless RiscValue.look_like_reg(right)
    end
    attr_reader :operator, :left , :right

    def to_s
      class_source "#{left} #{operator} #{right}"
    end

  end
  def self.op( source , operator , left , right )
    OperatorInstruction.new( source , operator , left , right )
  end

end
