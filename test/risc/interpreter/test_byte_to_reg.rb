require_relative "helper"

module Risc
  class TestInterpretRegToByte < MiniTest::Test
    include Ticker

    def setup
        @string_input = <<HERE
  class Space
    int main()
      "Hello".set_internal_byte(1,104)
    end
  end
HERE
      @input =  s(:statements, s(:call,
                     :set_internal_byte ,
                    s(:arguments, s(:int, 1), s(:int, 104)),
                      s(:receiver, s(:string, "Hello"))))
      super
    end

    def test_chain
      #show_ticks # get output of what is
      check_chain [Branch, Label, LoadConstant, SlotToReg, RegToSlot,
             LoadConstant, RegToSlot, FunctionCall, Label, SlotToReg,
             LoadConstant, RegToSlot, LoadConstant, RegToSlot, LoadConstant,
             SlotToReg, RegToSlot, LoadConstant, SlotToReg, RegToSlot,
             LoadConstant, SlotToReg, RegToSlot, LoadConstant, RegToSlot,
             RiscTransfer, FunctionCall, Label, LoadConstant, SlotToReg,
             RegToSlot, SlotToReg, SlotToReg, SlotToReg, SlotToReg,
             SlotToReg, RegToByte, Label, FunctionReturn, RiscTransfer,
             SlotToReg, SlotToReg, LoadConstant, SlotToReg, RegToSlot,
             Label, FunctionReturn, RiscTransfer, Syscall, NilClass]
    end

    def test_branch
      was = @interpreter.instruction
      assert_equal Branch , ticks(1).class
      assert was != @interpreter.instruction
      assert @interpreter.instruction , "should have gone to next instruction"
    end
    def test_load
      assert_equal LoadConstant ,  ticks(3).class
      assert_equal Parfait::Space , @interpreter.get_register(:r2).class
      assert_equal :r2,  @interpreter.instruction.array.symbol
    end
    def test_get
      assert_equal SlotToReg , ticks(4).class
      assert @interpreter.get_register( :r1 )
      assert Integer , @interpreter.get_register( :r1 ).class
    end
    def test_call
      assert_equal FunctionCall ,  ticks(8).class
    end
    def test_exit
      done = ticks(50)
      assert_equal NilClass ,  done.class
    end

    def test_reg_to_byte
      done = ticks(37)
      assert_equal RegToByte ,  done.class
      assert_equal "h".ord ,  @interpreter.get_register(done.register)
    end

  end
end