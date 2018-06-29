require_relative "../helper"

module RubyX
  module RubyXHelper
    def setup
      Risc.machine.boot
    end
    def ruby_to_vool(input)
      RubyXCompiler.ruby_to_vool(input)
    end
    def compile_in_test input
      vool = ruby_to_vool in_Test(input)
      vool.to_mom(nil)
      itest = Parfait.object_space.get_class_by_name(:Test)
      assert itest
      itest
    end

  end
end