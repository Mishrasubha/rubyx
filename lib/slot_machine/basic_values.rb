module SlotMachine
  # just name scoping the same stuff to slot
  # so we know we are on the way down, keeping our layers seperated
  # and we can put constant adding into the to_risc methods (instead of on sol classes)
  class Constant
  end

  class LambdaConstant < Constant
    attr_reader :lambda
    def initialize(bl)
      @lambda = bl
    end
    def to_parfait(compiler)
      @lambda
    end
  end

  class IntegerConstant < Constant
    attr_reader :value
    def initialize(value)
      @value = value
    end
    def to_parfait(compiler)
      value = Parfait.object_space.get_factory_for(:Integer).get_next_object
      value.set_value(@value)
      compiler.add_constant(value)
      value
    end
    def ct_type
      Parfait.object_space.get_type_by_class_name(:Integer)
    end
  end
  class FloatConstant < Constant
    attr_reader :value
    def initialize(value)
      @value = value
    end
    def ct_type
      true
    end
  end
  class TrueConstant < Constant
    def to_parfait(compiler)
      Parfait.object_space.true_object
    end
    def ct_type
      Parfait.object_space.get_type_by_class_name(:TrueClass)
    end
  end
  class FalseConstant < Constant
    def to_parfait(compiler)
      Parfait.object_space.false_object
    end
    def ct_type
      Parfait.object_space.get_type_by_class_name(:FalseClass)
    end
  end
  class NilConstant < Constant
    def to_parfait(compiler)
      Parfait.object_space.nil_object
    end
    def ct_type
      Parfait.object_space.get_type_by_class_name(:NilClass)
    end
  end
  class StringConstant < Constant
    attr_reader :value
    def initialize(value)
      @value = value
    end
    def to_parfait(compiler)
      value = Parfait.new_word(@value)
      compiler.add_constant(value)
      value
    end
    def ct_type
      Parfait.object_space.get_type_by_class_name(:Word)
    end
  end
  class SymbolConstant < Constant
    def ct_type
      Parfait.object_space.get_type_by_class_name(:Word)
    end
  end
end
