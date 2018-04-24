# 物件導向
## 物件導向(Object-Oriented Programming)一種將「資料」和「方法」封裝到物件的設計方式，我們定義「類別 Class」，然後依此產生出「物件 Object」，類別可說是物件的樣板。

## Ruby的類別其實也是一種常數，所以也是大寫開頭，使用new方法可以建立出物件，例如之前所學的字串、陣列和雜湊，也可以用以下方式建立：

color_string = String.new
color_string = "" # 等同

color_array = Array.new
color_array = [] # 等同

color_hash = Hash.new
color_hash = {} # 等同

time = Time.new # 內建的時間類別
puts time

## 來看看如何自定類別：

class Person # 大寫開頭的常數
  def initialize(name) # 建構式
    @name = name # 物件變數
  end

  def say(word)
    puts "#{word}, #{@name}" # 字串相加
  end
end

p1 = Person.new("ihower")
p2 = Person.new("ihover")

p1.say("Hello") # 輸出 Hello, ihower
p2.say("Hello") # 輸出 Hello, ihover
## 注意到雙引號裡的字串可以使用#{var}來做字串嵌入，相較起用加號+相加字串可以更有效率。

## 除了物件方法與物件變數，Ruby也有屬於類別的方法和變數：

class Person
  @@name = "ihower" # 類別變數

  def self.say # 類別方法
    puts @@name
  end
end

Person.say # 輸出 ihower

# 資料封裝
## 所有的物件變數(@開頭)、類別變數(@@開頭)，都是封裝在類別內部的，類別外無法存取：

class Person
  def initialize(name)
    @name = name
  end
end

p = Person.new("ihower")
p.name                      # 出現 NoMethodError 錯誤
p.name = "peny"             # 出現 NoMethodError 錯誤

## 為了可以存取到@name，我們必須定義方法：

class Person
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def name=(name)
    @name = name
  end
end

p = Person.new("ihower")
# => #<Person:0x007fe9e408b8f0 @name="ihower">
#p.name
# => "ihower"
#p.name = "peny"
# => "peny"
# p.name
# => "peny"
# p
# => #<Person:0x007fe9e408b8f0 @name="peny">

# 類別Class定義範圍內也可以執行程式
## 跟其他程式語言不太一樣，Ruby的類別層級內也可以執行程式，例如以下：

class Demo
  puts "foobar"
end

## 當你載入這個類別的時候，就會執行puts "foobar"輸出foobar。會放在這裡的程式，主要的用途是來做Meta-programming。例如，上述定義物件變數的存取方法實在太常見了，因此Ruby提供了attr_accessor、attr_writer、attr_reader類別方法可以直接定義這些方法。上述的程式可以改寫成：

class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

# p = Person.new('ihower')
# => #<Person:0x007fe9e3094410 @name="ihower">
# p.name
# => "ihower"
# p.name="peny"
# => "peny"
# p.name
# => "peny"
# p
# => #<Person:0x007fe9e3094410 @name="peny">
## 這裡的attr_accessor其實就是一個類別方法。

## Ruby的private和protected定義和其他程式語言不同，都是可以在整個繼承體系內呼叫。兩著差別在於private只有在物件內部才能呼叫，預設的接收者(receiver)就是物件本身，也就是self。而protected方法除了可以在本身內部呼叫以外，還可以被子類別的物件、或是另一個相同類別的物件呼叫。

## 在物件導向的術語中，object.call_method的意思是object收到執行call_method的指令，也就是object是call_method方法的接受者(receiver)。因此，你甚至可以改寫成object.__send__(:call_method)

class Pet
  attr_accessor :name, :age

  def say(word)
    puts "Say: #{word}"
  end
end

class Cat < Pet
  def say(word)
    puts "Meow~"
    super
  end
end

class Dog < Pet
  def say(word, person)
    puts "Bark at #{person}!"
    super(word)
  end
end

Cat.new.say("Hi")
Dog.new.say("Hi", "ihower")

## 沒有括號的super和有括號的super()是有差異的，前者Ruby會自動將所有參數都代進去來呼叫父類別的方法，後者則是自己指定參數。此例中如果Dog say裡只寫super，則會發生wrong number of arguments的錯誤，這是因為Ruby會傳say("Hi", "ihower")給Pet say而發生錯誤。

# Module
## Module是Ruby一個非常好用的功能，它跟Class類別非常相似，你可以在裡面定義方法。只是你不能用new來建立它。它的第一個用途是可以當做Namespace來放一些工具方法：

module MyUtil
  def self.foobar
    puts "foobar"
  end
end

MyUtil.foobar
# 輸出 foobar

## 另一個更重要的功能是Mixins，可以將一個Module混入類別之中，這樣這個類別就會擁有此Module的方法。這回讓我們拆成兩個檔案，debug.rb和foobar.rb，然後在foobar.rb中用require來引用debug.rb：

# 首先是debug.rb

module Debug
  def who_am_i?
    puts "#{self.class.name}: #{self.inspect}"
  end
end

## 然後是foobar.rb

require "./debug"

class Foo
  include Debug # 這個動作叫做 Mixin
end

class Bar
  include Debug
end

f = Foo.new
b = Bar.new
f.who_am_i? # 輸出 Foo: #<Foo:0x00000102829170>
b.who_am_i? # 輸出 Bar: #<Bar:0x00000102825b88>
## Ruby使用Module來解決多重繼承的問題，不同類別之間但是擁有相同的方法，就可以改放在Module裡面，然後include它即可。

# 迴圈走訪與迭代器Iterator
## 不同於while迴圈用法，Ruby習慣使用迭代器(Iterator)來走訪迴圈，例如each是一個陣列的方法，它會走訪其中的元素，其中的do ... end是each方法的參數，稱作Code Block，是一個匿名函式(anonymous function)。範例程式如下：

languages = ["Ruby", "Javascript", "Perl"]
languages.each do |lang|
  puts "I love #{lang}!"
end
# I Love Ruby!
# I Love Javascript!
# I Love Perl!
