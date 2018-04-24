require "./debug"

class Foo
  include Debug # 這個動作叫做 Mixin
end

class Bar
  include Debug
end

f = Foo.new
b = Bar.new
puts f.who_am_i? # 輸出 Foo: #<Foo:0x00000102829170>
puts b.who_am_i? # 輸出 Bar: #<Bar:0x00000102825b88>
