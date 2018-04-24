# Reference: http://www.ruby-lang.org/zh_tw/documentation/ruby-from-other-languages/

# 迭代 (Iteration)
## Ruby 有兩個常用的特色你可能沒見過，那就是 “程式區塊(blocks)” 和迭代子(iterators)”。不像使用索引的迴圈(例如 C, C++ 和 pre-1.5 Java)，或是迴圈控制結構(例如 Perl 的 for (@a) {...}，或是 Python 的 for i in aList: ...)。在 Ruby 裡你會常常看到：
some_list = [1, 2, 3]
some_list.each do |this_item|
  # 我們在程式區塊中
  # 處理 this_item
end

##關於更多 each 的資訊 (以及 collect, find, inject, sort 等等)，請參考 ri En umerable (和 ri Enumerable#some_method).

# 一切東西都有值
## 表達式(expression)和敘述(statement)沒有差別，都會有回傳值，即使那個值是 nil。例如下述用法：

x = 10
y = 11
z = if x < y
      true
    else
      false
    end
z # => true

# 所有東西都是物件
## “所有東西都是物件” 並不是誇大，甚至是類別跟整數也是物件，你可以與其他物件一樣操作它們：

# 這是等價的程式：
# class MyClass
#   attr_accessor :instance_var
# end
MyClass = Class.new do
  attr_accessor :instance_var
end
## 譯註：在 Ruby 中任何類別都是由 Class 類別所實例(new)出來的物件。

# 命名慣例
## Ruby 規定了一些命名慣例。變數的識別名稱，大寫字母開頭的是常數、錢號($)開頭的是全域變數、@ 開頭是實例變數(instance variable)、@@ 開頭則是類別變數。

## 方法名稱可以允許大寫字母開頭，雖然可能造成一些混淆，例如：

Constant = 10

def Constant
  11
end

## 這裡的 Constant 是 10，但是 Constant() 卻是 11。

# 關鍵字參數
## Ruby 自 2.0 起，方法可以使用關鍵字參數，用法與 Python 類似：

def deliver(from: "A", to: nil, via: "mail")
  "Sending from #{from} to #{to} via #{via}."
end

deliver(to: "B")
# => "Sending from A to B via mail."
deliver(via: "Pony Express", from: "B", to: "A")
# => "Sending from B to A via Pony Express."

# 一切為 true
## 在 Ruby 裡，除了 nil 和 false 之外的所有東西，都可以當做 true 值。在 C, Python 和其他語言中，0 和一些其他值，例如空列表，會被當做 false。例如我們看看以下的 Python 程式(其他語言亦同)：

# in Python
=begin
if 0:
  print("0 is true")
else:
  print("0 is false")
=end
## 這會輸出 “0 is false”。而在 Ruby 裡:

# in Ruby
if 0
  puts "0 is true"
else
  puts "0 is false"
end
## 這會輸出 “0 is true”。

# 存取修飾詞會作用到底
## 在下面的 Ruby 程式中，

class MyClass
  private

  def a_method; true; end
  def another_method; false; end
end

## 你可能會認為 another_method 是 public 的，但不是這樣。這個 private 存取修飾到作用域(scope)結束，或是直到另一個存取修飾詞開始作用。方法預設都是 public 的：

class MyClass
  # 這個 a_method 是 public 的
  def a_method; true; end

  private

  # 這個 another_method 是 private 的
  def another_method; false; end
end

## public, private 和 protected 其實也是一種方法，所以可以接受參數。如果你傳入一個 Symbol，那個該 Symbol 代表的方法就會改變存取權限。

# 方法存取權限
## 在 Java 裡，public 表示方法可以被任何人呼叫。protected 表示只有這個類別的實例、衍生類別的實例，以及相同 package 類別的實例可以呼叫，而 private 表示除了這個類別的實例之外，其他都不行呼叫。

## 在 Ruby 中，public 還是一樣是公開的意思，其他則有一點差異。private 表示只有不指定接受者(receiver)時才可以呼叫，也就是只有 self 可以當成 private 方法的接受者。

## protected 也有點不同。一個 protected 方法除了可以被一個類別或衍生類別的實例呼叫，也可以讓另一個相同類別的實例來當做接受者。 

# Missing 方法
## 當你呼叫一個不存在的方法，Ruby 仍然有辦法處理。它會改呼叫 method_missing 這個方法，並把這個不存在的方法名稱傳進去當做參數。method_missing 預設會丟出一個 NameError 例外，但是你可以根據你的需求重新定義過，也有許多函式庫這麼做。這是一個例子：

# id 是被呼叫方法的名字，而 * 符號會收集
# 所有傳進來的參數變成一個叫做 'arguments' 的陣列
def method_missing(id, *arguments)
  puts "Method #{id} was called, but not found. It has " +
       "these arguments: #{arguments.join(", ")}"
end

__ :a, :b, 10
# => Method __ was called, but not found. It has these
# arguments: a, b, 10

# Blocks 也算是物件
## 程式區塊 Blocks (或叫做 closures) 被廣泛應用在標準函式庫。要執行一個程式區塊，可以用 yield ，或是透過一個特別的參數讓它變成 Proc，例如：

def block(&the_block)
  # 在這裡面，the_block 是被傳進來的程式區塊
  the_block # return the block
end

adder = block { |a, b| a + b }
# adder 是一個 Proc 物件
adder.class # => Proc
## 你也可以透過 Proc.new 或 lambda 在方法外建立程式區塊。

## 同樣的，方法也可以當做物件：

method(:puts).call "puts is an object!"
# => puts is an object!
