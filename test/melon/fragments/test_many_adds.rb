require_relative 'helper'

module Melon
  class TestManyAdds < MiniTest::Test
    include MelonTests

    def pest_ruby_adds_looping
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

      counter = 100000

      while(counter > 0) do
      	fibo(40)
        counter -= 1
      end
HERE
      @length = 37
      @stdout = "Hello there"
      check
    end
  end
end
