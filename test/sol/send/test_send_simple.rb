require_relative "helper"

module Sol
  class TestSendSimpleSlotMachine < MiniTest::Test
    include SimpleSendHarness

    def send_method
      "5.div4;return"
    end
    def receiver
      [SlotMachine::IntegerConstant , 5]
    end
    def test_call_has_right_method
      assert_equal :div4,  @ins.next(2).method.name
    end
    def test_receiver_move
      assert_equal SlottedConstant,  @ins.next.receiver.class
    end

  end
end
