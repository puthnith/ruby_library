require 'pp' # 👈 Puts Pretty especially for Hash objects

require './lib/library.rb'
require './lib/visitor.rb'

sofia = Visitor.new("Sofia")
martin = Visitor.new("Martin")
rowling_library = Library.new('./lib/database/rowling_library.yml')
martin_library = Library.new('./lib/database/martin_library.yml')

rowling_library.reset # 👈 Make all books available to borrow
martin_library.reset

puts '--- Sofia\'s books ---'
puts "# sofia.books"
pp sofia.books
puts ''

puts '--- Martin\'s books ---'
puts "# martin.books"
pp martin.books
puts ''

puts '--- Books in the Rowling\'s library ---'
puts "# rowling_library.list_of_books"
pp rowling_library.list_of_books
puts ''

puts '--- Books in the Martin\'s library ---'
puts "# martin_library.list_of_books"
pp martin_library.list_of_books
puts ''

puts '--- Search "Fire" ---'
puts "# rowling_library.search(title: 'Fire')"
pp rowling_library.search(title: 'Fire')
puts ''

puts '--- Search "of" ---'
puts "# martin_library.search(title: 'of')"
pp martin_library.search(title: 'of')
puts ''

puts '--- Sofia borrows "Harry Potter and the Goblet of Fire" ---'
puts "# sofia.borrow_book(title: 'Harry Potter and the Goblet of Fire', library: rowling_library)"
pp sofia.borrow_book(title: 'Harry Potter and the Goblet of Fire', library: rowling_library)
puts ''

puts '--- Sofia borrows "Harry Potter and the Order of the Phoenix" ---'
puts "# sofia.borrow_book(title: 'Harry Potter and the Order of the Phoenix', library: rowling_library)"
pp sofia.borrow_book(title: 'Harry Potter and the Order of the Phoenix', library: rowling_library)
puts ''

puts '--- Sofia borrows "A Storm of Swords" ---'
puts "# sofia.borrow_book(title: 'A Storm of Swords', library: martin_library)"
pp sofia.borrow_book(title: 'A Storm of Swords', library: martin_library)
puts ''

puts '--- Martin borrows "Harry Potter and the Deathly Hallows" ---'
puts "# martin.borrow_book(title: 'Harry Potter and the Deathly Hallows', library: rowling_library)"
pp martin.borrow_book(title: 'Harry Potter and the Deathly Hallows', library: rowling_library)
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
puts "# sofia.borrow_book(title: 'Harry Potter and the Goblet of Fire', library: rowling_library)"
pp sofia.borrow_book(title: 'Harry Potter and the Goblet of Fire', library: rowling_library)
puts ''

puts '--- Sofia borrows "Harry Potter and the Deathly Hallows" which was borrowed by Martin ---'
puts "# sofia.borrow_book(title: 'Harry Potter and the Deathly Hallows', library: rowling_library)"
pp sofia.borrow_book(title: 'Harry Potter and the Deathly Hallows', library: rowling_library)
puts ''

puts '--- Sofia borrows "Men without Women" which does not exist ---'
puts "# sofia.borrow_book(title: 'Men without Women', library: rowling_library)"
pp sofia.borrow_book(title: 'Men without Women', library: rowling_library)
puts ''

puts '--- Sofia\'s books ---'
puts "# sofia.books"
pp sofia.books
puts ''

puts '--- Books in the Rowling\'s library ---'
puts "# rowling_library.list_of_books"
pp rowling_library.list_of_books
puts ''

puts '--- Books in the Martin\'s library ---'
puts "# martin_library.list_of_books"
pp martin_library.list_of_books
puts ''

puts '--- Martin returns "Harry Potter and the Goblet of Fire" which is not borrowed by him ---'
puts "# martin.return_book(title: 'Harry Potter and the Goblet of Fire', library: rowling_library)"
pp martin.return_book(title: 'Harry Potter and the Goblet of Fire', library: rowling_library)
puts ''

puts '--- Martin returns "Harry Potter and the Half-Blood Prince" which is available in library ---'
puts "# martin.return_book(title: 'Harry Potter and the Half-Blood Prince', library: rowling_library)"
pp martin.return_book(title: 'Harry Potter and the Half-Blood Prince', library: rowling_library)
puts ''

puts '--- Sofia returns "Harry Potter and the Goblet of Fire" which is borrowed by her ---'
puts "# sofia.return_book(title: 'Harry Potter and the Goblet of Fire', library: rowling_library)"
pp sofia.return_book(title: 'Harry Potter and the Goblet of Fire', library: rowling_library)
puts ''

puts '--- Sofia returns "A Dance with Dragons" which is not borrowed by her ---'
puts "# sofia.return_book(title: 'A Dance with Dragons', library: martin_library)"
pp sofia.return_book(title: 'A Dance with Dragons', library: martin_library)
puts ''

puts '--- Sofia\'s books ---'
puts "# sofia.books"
pp sofia.books
puts ''

puts '--- Martin\'s books ---'
puts "# martin.books"
pp martin.books
puts ''

puts '--- Books in the Rowling\'s library ---'
puts "# rowling_library.list_of_books"
pp rowling_library.list_of_books
puts ''

puts '--- Books in the Martin\'s library ---'
puts "# martin_library.list_of_books"
pp martin_library.list_of_books
puts ''
