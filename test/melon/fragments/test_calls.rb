require_relative 'helper'

module Melon
  class TestRubyCalls < MiniTest::Test
    include MelonTests

    def pest_ruby_calls
      @string_input = <<HERE

      def fibo_r( n )
         if( n <  2 )
            return n
         else
            return fibo_r(n - 1) + fibo_r(n - 2)
         end
      end

      fibo 40
HERE
      @stdout = "Hello there"
      check
    end
  end
end
