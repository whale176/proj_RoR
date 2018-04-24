# 流程控制Flow Control
## 讓我們來看看一些流程控制：

## 比較方法
puts 1 > 2 # 大於
puts 1 < 2 # 小於
puts 5 >= 5 # 大於等於
puts 5 <= 4 # 小於等於
puts 1 == 1 # 等於
puts 2 != 1 # 不等於

puts (2 > 1) && (2 > 3) # 和
puts (2 > 1) || (2 > 3) # 或

# 控制結構If
## else if寫成elsif：

total = 26000

if total > 100000
  puts "large account"
elsif total > 25000
  puts "medium account"
else
  puts "small account"
end

## 另外如果要執行的if程式只有一行，可以將if放到行末即可：
puts "greater than ten" if total > 10

# 三元運算子
## 三元運算子expression ? true_expresion : false_expression可以讓我們處理簡易的if else條件，例如以下的程式：

x = 3
if x > 3
  y = "foo"
else
  y = "bar"
end

##改用三元運算子之後，可以縮減程式行數：

x = 3
y = (x > 3) ? "foo" : "bar"

# 控制結構Case
name = "maia"
case name
when "John"
  puts "Howdy John!"
when "Ryan"
  puts "Whatz up Ryan!"
else
  puts "Hi #{name}!"
end

# 迴圈 while, loop, until, next and break
## while用法範例：

i = 0
arr = []
while (i < 10)
  i += 1
  next if i % 2 == 0 #跳過雙數
  arr.push(i)
end

puts arr.inspect

## until用法範例：

i = 0
i += 1 until i > 10
puts i
# 輸出 11
## loop用法範例：

i = 0
loop do
  i += 1
  break if i > 10 # 中斷迴圈
end
## 不過你很快就會發現寫Ruby很少用到while、until、loop，我們會使用迭代器。

# 真或假
## 記住，只有false和nil是假，其他都為真。

puts "not execute" if nil
puts "not execute" if false

puts "execute" if true # 輸出 execute
puts "execute" if "" # 輸出 execute (和JavaScript不同)
puts "execute" if 0 # 輸出 execute (和C不同)
puts "execute" if 1 # 輸出 execute
puts "execute" if "foo" # 輸出 execute
puts "execute" if Array.new # 輸出 execute

# 正規表示法Regular Expressions
## 與Perl類似的語法，使用=~：

# 抓出手機號碼
phone = "123-456-7890"
if phone =~ /(\d{3})-(\d{3})-(\d{4})/
  ext = $1
  city = $2
  num = $3
end

puts ext + " " + city + " " + num

# 方法定義Methods
## 使用 def 開頭 end 結尾來定義一個方法：

def say_hello(name)
  result = "Hi, " + name
  return result
end

puts say_hello("ihower")

# 輸出 Hi, ihower
## 方法中的return是可以省略的，Ruby就會回傳最後一行運算的值。上述方法可以改寫成：

def say_hello(name)
  "Hi, " + name
end

puts say_hello("there")

## 呼叫方法時，括號也是可以省略的，例如：
## say_hello 'ihower'
## 不過，除了一些方法慣例不加之外
## (例如puts和Rails中的redirect_to、render方法)，絕大部分的情況加上括號比較無疑義。

## 我們也可以給參數預設值：

def say_hello(name = "nobody")
  result = "Hi, " + name
  return result
end

puts say_hello
# 輸出 Hi, nobody

# ?與!的慣例
## 方法名稱可以用?或!結尾，
## 前者表示會回傳Boolean值，後者暗示會有某種副作用(side-effect)。
## 範例如下：

array = [2, 1, 3]

array.empty? # false
array.sort # [1,2,3]

array.inspect # [2,1,3]

array.sort! # [1,2,3]
array.inspect # [1,2,3]

# Symbols 不是輕量化的字串
## 許多 Ruby 新手會搞不清楚什麼是 Symbols(符號) 可以做什麼用。

## Symbols 就如同一個識別符號。一個 symbol 就代表它是”誰”了，而不是代表它是”什麼”。打開 irb 來看一看它們的區別：

=begin
  irb(main):001:0> :george.object_id == :george.object_id
  => true
  irb(main):002:0> "george".object_id == "george".object_id
  => false
  irb(main):003:0>
=end

## object_id 方法會回傳物件的識別編號。如果有兩個物件有相同的 object_id 表示它們其實是同一個(指向同一個記憶體位置)。 如你所見，使用過 Symbols 之後，任何相同名字的 Symbol 都是指記憶體裡的同一個物件。對任何相同名字的 Symbols，它們的 object_id 都一樣。

## 讓我們來看看字串 “george”，它們的 object_id 並不相同。這表示它們在記憶體裡面是不同的物件。每次你建立一個新的字串，Ruby 就會分配新的記憶體空間給它。

## 如果你不清楚何時使用 Symbol 何時用字串(String)，想想看用途究竟是物件的識別(例如一個雜湊 Hash 的 key)，還是物件內容(比如這個例子的 “george”)。
