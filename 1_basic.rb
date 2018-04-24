fruits = ["kiwi", "strawberry", "plum"]
puts fruits
puts "=============="
fruits = fruits + ["orange"]
puts fruits
puts "=============="
fruits = fruits - ["kiwi"]
puts fruits
puts "=============="

# String
var1 = "stop"
var2 = "foobar"
var3 = "aAbBcC"

puts var1.reverse # pots
puts var2.length # 6
puts var3.upcase # AABBCC
puts var3.downcase # aabbcc
puts "=============="

verb = "work"
where = "office"

puts "I #{verb} at the #{where}" # 輸出 I work at the office
puts "I #{verb} at the #{where}" # 輸出 I #{verb} at the #{where}
puts "=============="

# Objects

puts "upper".upcase  # 輸出「UPPER」
puts -5.abs  # 輸出 -5 的絕對值
puts 99.class  # 輸出 Fixnum 類別

5.times do
  puts "Ruby Rocks!"  # 輸出五次「Ruby Rocks!」
end
puts "=============="

# variable
###區域變數Local Variable
###區域變數使用小寫開頭，偏好單字之間以底線_來分隔。範例如下：

composer = "Mozart"
puts composer + ' was "da bomb", in his day.'

my_composer = "Beethoven"
puts "But I prefer " + my_composer + ", personally."

puts "=============="

#型別轉換Conversions
##數字和字串物件不能直接相加，你必須使用
# to_s(轉成字串)、
# to_i(轉成整數)
# 或to_f(轉成浮點數)來手動轉型，範例如下：

var1 = 2
var2 = "5"

puts var1.to_s + var2 # 25
puts var1 + var2.to_i # 7

puts 9 / 2  # 4
puts 9.to_f / 2 # 4.5

puts "=============="

# 常數Constant
## 大寫開頭的是為常數

Foo = 1
# Foo = 2 # (irb):3: warning: already initialized constant Foo

RUBY_PLATFORM # => "x86_64-darwin10.7.0"
ENV # => { "PATH" => "....", "LC_ALL" => "zh_TW.UTF-8" }

puts "=============="

# 空值nil
## 表示未設定值、未定義的狀態：

nil # nil
nil.class # NilClass

nil.nil? # true
42.nil? # false

nil == nil # true
false == nil # false

# 字串符號Symbols
## Symbol是唯一且不會變動的識別名稱，用冒號開頭：

:this_is_a_symbol
## 為什麼不就用字串呢？這是因為相同名稱的Symbol不會再重複建構物件，所以使用Symbol可以執行的更有效率。範例如下：

puts "foobar".object_id      # 輸出 2151854740
puts "foobar".object_id      # 輸出 2151830100
puts :foobar.object_id       # 輸出 577768
puts :foobar.object_id       # 輸出 577768

# 雜湊Hash
## Hash是一種鍵值對(Key-Value)的資料結構，雖然你可以使用任何物件當作Key，但是通常我們使用Symbol當作Key。例如：

config = {:foo => 123, :bar => 456}
puts config[:foo] # 輸出 123
config["nothing"] # 是 nil

## 在Ruby 1.9後支援新的語法，比較簡約：
config = {foo: 123, bar: 456} # 等同於 { :foo => 123, :bar => 456 }

## 使用each方法可以走訪雜湊：

config = {:foo => 123, :bar => 456}
config.each do |key, value|
  puts "#{key} is #{value}"
end

# foo is 123
# bar is 456

# 陣列Array
## 使用中括號，索引從0開始。注意到陣列中的元素是不限同一類別，想放什麼都可以：

a = [1, "cat", 3.14]

puts a[0] # 輸出 1
puts a.size # 輸出 3

a[2] = nil
puts a.inspect # 輸出 [1, "cat", nil] # inspect方法會將物件轉成適合給人看的字串
a[99] # nil

colors = ["red", "blue"]

colors.push("black")
colors << "white"
puts colors.join(", ") # red, blue, black, white

colors.pop
puts colors.last #black

## 使用each方法走訪陣列：

languages = ["Ruby", "Javascript", "Perl"]

languages.each do |lang|
  puts "I love " + lang + "!"
end

# I Love Ruby!
# I Love Javascript!
# I Love Perl!
