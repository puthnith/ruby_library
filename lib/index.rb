require 'pp' # 👈 Puts Pretty especially for Hash objects

require './lib/library.rb'
require './lib/visitor.rb'

visitor = Visitor.new("Martin")
library = Library.new

puts '--- Books in the library ---'
library.reset # 👈 Make all books available to borrow
puts "# library.list_of_books"
pp library.list_of_books
puts ''

puts '--- Visitor\'s books ---'
puts "# visitor.books"
pp visitor.books
puts ''

puts '--- Search "Fire" ---'
puts "# library.search(title: 'Fire')"
pp library.search(title: 'Fire')
puts ''

puts '--- Visitor borrows "Harry Potter and the Goblet of Fire" ---'
puts "# visitor.borrow(title: 'Harry Potter and the Goblet of Fire', library: library)"
pp visitor.borrow(title: 'Harry Potter and the Goblet of Fire', library: library)
puts ''

puts '--- Visitor borrows "Harry Potter and the Order of the Phoenix" ---'
puts "# visitor.borrow(title: 'Harry Potter and the Order of the Phoenix', library: library)"
pp visitor.borrow(title: 'Harry Potter and the Order of the Phoenix', library: library)
puts ''

puts '--- Visitor\'s books ---'
puts "# visitor.books"
pp visitor.books
puts ''

puts '--- Visitor borrows "Harry Potter and the Goblet of Fire" again ---'
puts "# visitor.borrow(title: 'Harry Potter and the Goblet of Fire', library: library)"
pp visitor.borrow(title: 'Harry Potter and the Goblet of Fire', library: library)
puts ''

puts '--- Visitor borrows "Men without Women" ---'
puts "# visitor.borrow(title: 'Men without Women', library: library)"
pp visitor.borrow(title: 'Men without Women', library: library)
puts ''

puts '--- Visitor\'s books ---'
puts "# visitor.books"
pp visitor.books
puts ''

puts '--- Books in the library ---'
puts "# library.list_of_books"
pp library.list_of_books
puts ''
