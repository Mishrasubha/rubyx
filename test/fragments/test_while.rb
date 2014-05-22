require_relative 'helper'

class TestWhile < MiniTest::Test
  include Fragments

  def test_while
    @string_input = <<HERE
    def fibonaccit(n) # n == r0
      a = 0           # a == r1
      b = 1           # b = r2
      while( n > 1 ) do                   #BUG comment lines + comments behind function calls
        tmp = a       # r3 <- r1
        a = b         # r1 <- r2
        b = tmp + b   #  r4 = r2 + r3  (r4 transient)  r2 <- r4 
        n = n - 1      # r0 <- r2   for call,    #call ok  
      end             #r5 <- r0 - 1    n=n-1 through r5 tmp              
      putint(b)
    end               # r0 <- r5

    fibonaccit( 10 )
HERE
    @should = [0x0,0xb0,0xa0,0xe3,0xe,0x0,0x2d,0xe9,0xa,0x0,0xa0,0xe3,0x2,0x0,0x0,0xeb,0xe,0x0,0xbd,0xe8,0x1,0x70,0xa0,0xe3,0x0,0x0,0x0,0xef,0x0,0x40,0x2d,0xe9,0x0,0x10,0xa0,0xe3,0x1,0x20,0xa0,0xe3,0x1,0x0,0x50,0xe3,0x1,0x30,0xa0,0xe1,0x2,0x10,0xa0,0xe1,0x2,0x40,0x83,0xe0,0x4,0x20,0xa0,0xe1,0x1,0x50,0x40,0xe2,0x5,0x0,0xa0,0xe1,0xe,0x0,0x2d,0xe9,0x2,0x0,0xa0,0xe1,0x12,0x0,0x0,0xeb,0xe,0x0,0xbd,0xe8,0x0,0x80,0xbd,0xe8,0x0,0x40,0x2d,0xe9,0xa,0x20,0x41,0xe2,0x21,0x11,0x41,0xe0,0x21,0x12,0x81,0xe0,0x21,0x14,0x81,0xe0,0x21,0x18,0x81,0xe0,0xa1,0x11,0xa0,0xe1,0x1,0x31,0x81,0xe0,0x83,0x20,0x52,0xe0,0x1,0x10,0x81,0x52,0xa,0x20,0x82,0x42,0x30,0x20,0x82,0xe2,0x0,0x20,0xc0,0xe5,0x1,0x0,0x40,0xe2,0x0,0x0,0x51,0xe3,0xef,0xff,0xff,0x1b,0x0,0x80,0xbd,0xe8,0x0,0x40,0x2d,0xe9,0x0,0x10,0xa0,0xe1,0x24,0x0,0x8f,0xe2,0x9,0x0,0x80,0xe2,0xe9,0xff,0xff,0xeb,0x18,0x0,0x8f,0xe2,0xc,0x10,0xa0,0xe3,0x1,0x20,0xa0,0xe1,0x0,0x10,0xa0,0xe1,0x1,0x0,0xa0,0xe3,0x4,0x70,0xa0,0xe3,0x0,0x0,0x0,0xef,0x0,0x80,0xbd,0xe8,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x20,0x0]
    parse 
    write "while"
  end
end

