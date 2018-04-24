require "./game"
require "./person"
require "./deck"

arr = ['A', *'2'..'10', 'J', 'Q', 'K']
cards = ['spade', 'heart', 'diamond', 'club'].product(arr)

puts cards
