require 'pp' # 👈 Puts Pretty especially for Hash objects

require './lib/library.rb'
require './lib/visitor.rb'

visitor = Visitor.new
library = Library.new

puts '--- Books in the library ---'
library.reset # Make all books available to borrow
pp library.list_of_books
puts ''

puts '--- Visitor\'s books ---'
pp visitor.books
puts ''

puts '--- Search "Fire" ---'
pp library.search(title: "Fire")
puts ''

puts '--- Borrow "Harry Potter and the Goblet of Fire" ---'
pp visitor.borrow(title: "Harry Potter and the Goblet of Fire", library: library)
puts ''

puts '--- Visitor borrows "Harry Potter and the Goblet of Fire" ---'
pp visitor.borrow(
  title: "Harry Potter and the Goblet of Fire",
  library: library
)
puts ''

puts '--- Visitor\'s books ---'
pp visitor.books
puts ''

puts '--- Visitor borrows "Harry Potter and the Goblet of Fire" again ---'
pp visitor.borrow(
  title: "Harry Potter and the Goblet of Fire",
  library: library
)
puts ''

puts '--- Visitor borrows "Men without Women" ---'
pp visitor.borrow(
  title: "Men without Women",
  library: library
)
puts ''

puts '--- Visitor\'s books ---'
pp visitor.books
puts ''

puts '--- Books in the library ---'
pp library.list_of_books
puts ''
