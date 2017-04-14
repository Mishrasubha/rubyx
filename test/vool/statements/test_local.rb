require_relative "helper"

module Vool
  class TestLocal < MiniTest::Test

    def test_local
      lst = RubyCompiler.compile( "foo = bar")
      assert_equal LocalAssignment , lst.class
    end
    def test_local_name
      lst = RubyCompiler.compile( "foo = bar")
      assert_equal :foo , lst.name
    end

  end
end