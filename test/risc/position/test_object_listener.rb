require_relative "helper"

module Risc
  class TestPositionListener < MiniTest::Test

    def setup
      @object = Dummy.new
      @dependent = Dummy.new
      @pos = Position.new(@object,0)
      Position.new(@dependent,0)
      @listener = PositionListener.new(@dependent)
    end
    def test_register
      assert @pos.position_listener(@listener)
    end
    def test_no_fire
      @pos.position_listener(self)
      Position.set_to(@pos,0)
      assert_equal 0 , Position.get(@object).at
    end
    def test_reset
      @pos.position_listener( @listener)
      Position.set_to(@pos,4)
      assert_equal 0 , Position.at(4).at
    end
  end
end
