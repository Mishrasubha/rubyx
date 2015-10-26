# An Object is really a hash like structure. It is dynamic and
# you want to store values by name (instance variable names).
#
# One could (like mri), store the names in each object, but that is wasteful
# Instead we store only the values, and access them by index.
# The Layout allows the mapping of names to index.

# The Layout of an object describes the memory layout of the object
# The Layout is a simple list of the names of instance variables.
#
# As every object has a Layout to describe it, the name "layout" is the
# first name in the list for every Layout.

# But as we want every Object to have a class, the Layout carries that class.
# So the layout of layout has an entry "object_class"

# But Objects must also be able to carry methods themselves (ruby calls singleton_methods)
# and those too are stored in the Layout (both layout and class include behaviour)

# In other words, the Layout is a list of names that describe
# the values stored in an actual object.
# The object is an List of values of length n and
# the Layout is an List of names of length n , plus class reference and methods reference
# Together they turn the object into a hash like structure

module Parfait
  class Layout < Object
    attribute :object_class
    include Behaviour

    include Indexed
    self.offset(3)

    def initialize( object_class )
      super()
      self.object_class = object_class
      add_instance_variable :layout
    end

    def == other
      self.object_id == other.object_id
    end

    # add the name of an instance variable
    # The index will be returned and can subsequently be searched with index_of
    # The index of the name is the index of the data in the object
    #
    # TODO , later we would need to COPY the layout to keep the old constant
    #        but now we are concerned with booting, ie getting a working structure
    def add_instance_variable name
      self.push(name)
      self.get_length
    end

    def instance_names
      names = List.new
      each do |item|
        names.push item
      end
      names
    end

    def instance_length
      self.get_length
    end

    # index of the variable when using internal_object_get
    # (internal_object_get is 1 based and 1 is always the layout)
    def variable_index name
      has = index_of(name)
      return nil unless has
      raise "internal error #{name}:#{has}" if has < 1
      has
    end

    def inspect
      "Layout[#{super}]"
    end

    def sof_reference_name
      "#{self.object_class.name}_Layout"
    end

  end
end
