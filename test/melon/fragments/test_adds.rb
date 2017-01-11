require_relative 'helper'

module Melon
  class TestRubyAdds < MiniTest::Test
    include MelonTests

    def pest_ruby_adds
      @string_input = <<HERE
      def fibo( n)
      	 a = 0
      	 b = 1
      	 i = 1
        while( i < n ) do
          result = a + b
          a = b
          b = result
          i+= 1
        end
      	return result
      end
HERE
      @stdout = "Hello there"
      check
    end
  end
end
