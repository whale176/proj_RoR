class Some
end

s1 = Some.new

def s1.some
  puts "some"
end

s1.some

## 定義於 s1 上的 some 方法，稱為 s1 參考物件的 單例方法（Singleton method）
## 僅屬於 s1 參考物件所擁有，同為 Some 實例的 s2 不會擁有該方法。
# s2 = Some.new
# s2.some

# 如果想移除物件上的單例方法，可以如下：

# class << s1
#   remove_method :some
# end

# s1.some

## 單例方法 實際上是定義在物件的匿名單例類別（Anonymous singleton class）上，class << object 語法，就是用來開啟 object 的單例類別，由於 << 在 Ruby 中往往有附加的意涵，而單例類別是沒有名稱的，所以 class << object 也可讀作，在 object 的匿名單例類別中追加定義。
