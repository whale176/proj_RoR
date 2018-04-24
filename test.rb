class Some
  @@z = 5
  def self.x
    @@y = 10
  end
end

puts Some::z
