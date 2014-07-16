require_relative 'helper'

class TestStringClass < MiniTest::Test
  include Fragments

  def test_string_class
    @string_input = <<HERE
class Object
  def raise()
    putstring()
    exit()
  end
  def method_missing(name,args)
    name.raise()
  end
  def class()
    l = @layout
    return l.class()
  end
  def resolve_method(name)
    clazz = class()
    function = clazz._get_instance_variable(name)
    index = clazz.index_of(name)
    if( function == 0 )
      name.raise()
    else
      return function
    end
  end
  def index_of( name )
    l = @layout
    return l.index_of(name) 
  end
  def layout()
    return @layout
  end
end
class Class
  def Class.new_object( length )
    return 4
  end
end
class String
  def String.new_string( len )
    return Class.new_object( len << 2 )
  end
  def length()
    return @length
  end
  def plus(str)
    my_length = @length 
    str_len = str.length()
    new_string = String.new_string(my_length + str_len)
    i = 0
    while( i < my_length) do
      char = get(i)
      new_string.set(i , char)
      i = i + 1
    end
    i = 0
    while( i < str_len) do
      char = str.get(i)
      new_string.set( i + my_length , char)
      i = i + 1
    end
    return new_string
  end
end
HERE
    @should = [0x0,0xb0,0xa0,0xe3,0x2a,0x10,0xa0,0xe3,0x13,0x0,0x0,0xeb,0x1,0x70,0xa0,0xe3,0x0,0x0,0x0,0xef,0x0,0x70,0xa0,0xe1,0x0,0x40,0x2d,0xe9,0xa,0x30,0x42,0xe2,0x22,0x21,0x42,0xe0,0x22,0x22,0x82,0xe0,0x22,0x24,0x82,0xe0,0x22,0x28,0x82,0xe0,0xa2,0x21,0xa0,0xe1,0x2,0x41,0x82,0xe0,0x84,0x30,0x53,0xe0,0x1,0x20,0x82,0x52,0xa,0x30,0x83,0x42,0x30,0x30,0x83,0xe2,0x0,0x30,0xc1,0xe5,0x1,0x10,0x41,0xe2,0x0,0x0,0x52,0xe3,0xef,0xff,0xff,0x1b,0x0,0x80,0xbd,0xe8,0x0,0x40,0x2d,0xe9,0x1,0x20,0xa0,0xe1,0x20,0x10,0x8f,0xe2,0x9,0x10,0x81,0xe2,0xe9,0xff,0xff,0xeb,0x14,0x10,0x8f,0xe2,0xc,0x20,0xa0,0xe3,0x1,0x0,0xa0,0xe3,0x4,0x70,0xa0,0xe3,0x0,0x0,0x0,0xef,0x0,0x70,0xa0,0xe1,0x0,0x80,0xbd,0xe8,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20]
    @output = "        42  "
    parse
    @target = [:String , :plus]
    write "class"
  end

  def parse 
    parser = Parser::Kide.new
    syntax  = parser.parse_with_debug(@string_input)
    parts   = Parser::Transform.new.apply(syntax)
    # file is a list of expressions, all but the last must be a function
    # and the last is wrapped as a main
    parts.each_with_index do |part,index|
      if index == (parts.length - 1)
        expr    = part.compile( @object_space.context )
      else
        expr    = part.compile( @object_space.context )
        raise "should be function definition for now, not #{part.inspect}#{expr.inspect}" unless expr.is_a? Boot::BootClass
      end
    end
  end

end

