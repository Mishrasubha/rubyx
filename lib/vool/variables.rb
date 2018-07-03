module Vool
  module Named
    attr_reader :name
    def initialize name
      @name = name
    end
    def each(&block)
    end
  end

  class LocalVariable < Expression
    include Named
    def slot_definition(method)
      if method.arguments_type.variable_index(@name)
        type = :arguments
      else
        type = :frame
      end
      Mom::SlotDefinition.new(:message , [type , @name])
    end
    def to_s
      name.to_s
    end
  end

  class InstanceVariable < Expression
    include Named
    def slot_definition(method)
      Mom::SlotDefinition.new(:message , [ :receiver , @name] )
    end
    # used to collect type information
    def add_ivar( array )
      array << @name
    end
    def to_s
      "@#{name}"
    end
  end

  class ClassVariable < Expression
    include Named
  end

  class ModuleName < Expression
    include Named
  end
end
