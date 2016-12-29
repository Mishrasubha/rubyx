# almost simplest hash imaginable. make good use of Lists

module Parfait
  class Dictionary < Object
    def self.attributes
      [:keys, :values]
    end

    # only empty initialization for now
    #
    # internally we store keys and values in lists, which means this does **not** scale well
    def initialize
      super()
      @keys = List.new()
      @values = List.new()
    end

    attr_reader :values , :keys  #FIXME these should be dupped, not handed out

    # are there any key/value items in the list
    def empty?
      @keys.empty?
    end

    # How many key/value pairs there are
    def length()
      return @keys.get_length()
    end

    # get a value fot the given key
    # key identity is checked with == not === (ie equals not identity)
    # return nil if no such key
    def get(key)
      index = key_index(key)
      if( index )
        @values.get(index)
      else
        nil
      end
    end

    # same as get(key)
    def [](key)
      get(key)
    end

    # private method
    def key_index(key)
      len = @keys.get_length()
      index = 1
      found = nil
      while(index <= len)
        if( @keys.get(index) == key)
          found = index
          break
        end
        index += 1
      end
      found
    end

    # set key with value, returns value
    def set(key , value)
      index = key_index(key)
      if( index )
        @keys.set(index , value)
      else
        @keys.push(key)
        @values.push(value)
      end
      value
    end

    #same as set(k,v)
    def []=(key,val)
      set(key,val)
    end

    # yield to each key value pair
    def each
      index = 1
      while index <= @keys.get_length
        key = @keys.get(index)
        value = @values.get(index)
        yield key , value
        index = index + 1
      end
      self
    end

    def inspect
      string = "Dictionary{"
      each do |key , value|
        string += key.to_s + " => " + value.to_s + " ,"
      end
      string + "}"
    end

    def to_sof_node(writer , level , ref)
      Sof.hash_to_sof_node( self , writer , level , ref)
    end
  end
end
