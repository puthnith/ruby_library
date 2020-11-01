require 'pp' # 👈 Puts Pretty especially for Hash objects

require './lib/library.rb'
require './lib/visitor.rb'

sofia = Visitor.new("Sofia")
martin = Visitor.new("Martin")
library = Library.new

puts '--- Books in the library ---'
library.reset # 👈 Make all books available to borrow
puts "# library.list_of_books"
pp library.list_of_books
puts ''

puts '--- Sofia\'s books ---'
puts "# sofia.books"
pp sofia.books
puts ''

puts '--- Martin\'s books ---'
puts "# martin.books"
pp martin.books
puts ''

puts '--- Search "Fire" ---'
puts "# library.search(title: 'Fire')"
pp library.search(title: 'Fire')
puts ''

puts '--- Sofia borrows "Harry Potter and the Goblet of Fire" ---'
puts "# sofia.borrow_book(title: 'Harry Potter and the Goblet of Fire', library: library)"
pp sofia.borrow_book(title: 'Harry Potter and the Goblet of Fire', library: library)
puts ''

puts '--- Sofia borrows "Harry Potter and the Order of the Phoenix" ---'
puts "# sofia.borrow_book(title: 'Harry Potter and the Order of the Phoenix', library: library)"
pp sofia.borrow_book(title: 'Harry Potter and the Order of the Phoenix', library: library)
puts ''

puts '--- Martin borrows "Harry Potter and the Deathly Hallows" ---'
puts "# martin.borrow_book(title: 'Harry Potter and the Deathly Hallows', library: library)"
pp martin.borrow_book(title: 'Harry Potter and the Deathly Hallows', library: library)
puts ''

puts '--- Sofia\'s books ---'
puts "# sofia.books"
pp sofia.books
puts ''

puts '--- Martin\'s books ---'
puts "# martin.books"
pp martin.books
puts ''

puts '--- Sofia borrows "Harry Potter and the Goblet of Fire" again ---'
puts "# sofia.borrow_book(title: 'Harry Potter and the Goblet of Fire', library: library)"
pp sofia.borrow_book(title: 'Harry Potter and the Goblet of Fire', library: library)
puts ''

puts '--- Sofia borrows "Harry Potter and the Deathly Hallows" which was borrowed by Martin ---'
puts "# sofia.borrow_book(title: 'Harry Potter and the Deathly Hallows', library: library)"
pp sofia.borrow_book(title: 'Harry Potter and the Deathly Hallows', library: library)
puts ''

puts '--- Sofia borrows "Men without Women" which does not exist ---'
puts "# sofia.borrow_book(title: 'Men without Women', library: library)"
pp sofia.borrow_book(title: 'Men without Women', library: library)
puts ''

puts '--- Sofia\'s books ---'
puts "# sofia.books"
pp sofia.books
puts ''

puts '--- Books in the library ---'
puts "# library.list_of_books"
pp library.list_of_books
puts ''

puts '--- Martin returns "Harry Potter and the Goblet of Fire" which is not borrowed by him ---'
puts "# martin.return_book(title: 'Harry Potter and the Goblet of Fire', library: library)"
pp martin.return_book(title: 'Harry Potter and the Goblet of Fire', library: library)
puts ''

puts '--- Martin returns "Harry Potter and the Half-Blood Prince" which is available in library ---'
puts "# martin.return_book(title: 'Harry Potter and the Half-Blood Prince', library: library)"
pp martin.return_book(title: 'Harry Potter and the Half-Blood Prince', library: library)
puts ''

puts '--- Sofia returns "Harry Potter and the Goblet of Fire" which is borrowed by her ---'
puts "# sofia.return_book(title: 'Harry Potter and the Goblet of Fire', library: library)"
pp sofia.return_book(title: 'Harry Potter and the Goblet of Fire', library: library)
puts ''

puts '--- Sofia\'s books ---'
puts "# sofia.books"
pp sofia.books
puts ''

puts '--- Martin\'s books ---'
puts "# martin.books"
pp martin.books
puts ''

puts '--- Books in the library ---'
puts "# library.list_of_books"
pp library.list_of_books
puts ''
