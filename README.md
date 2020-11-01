# Library

## Install

```none
💎 gem install bundler
💎 bundle install
```

## Unit Tests

```none
🧪 rspec

Library
  is expected to load books from YAML file on initialized
  is able to search books by titles
  is able to search books by authors
  is able to search books by titles and authors
  returns empty array if no title or author provided to search
  is expected to provide a list of books to visitors
  is able to reset all books to be available and save to database
  is expected for visitors to
    checkout and get
      an error if no title
      an error if no visitor
      not found if title of book does not exist
      not available if title of book is not available
      book as database is updated if title of book exists
    checkin and get
      an error if no title
      an error if no visitor
      not found if title of book does not exist
      not borrowed if title of book is not borrowed by him
      success as database is updated if title of book is borrowed by him

Visitor
  is expected to have a name on initialize
  is expected to have empty books list on initialize
  can borrow book as he
    raises error if no library
    raises error if no title
    returns message if given library and a title
    calls checkout to library
    updates his books upon success
    does nothing to his books upon failure
  can return book as he
    raises error if no library
    raises error if no title
    returns message if given library and a title
    calls checkin to library
    updates his books upon success
    does nothing to his books upon failure

Finished in 0.03548 seconds (files took 0.16787 seconds to load)
31 examples, 0 failures
```

## Simulation

```none
💎 ruby './lib/index.rb'

--- Sofia's books ---
# sofia.books
[]

--- Martin's books ---
# martin.books
[]

--- Books in the Rowling's library ---
# rowling_library.list_of_books
[{:item=>
   {:title=>"Harry Potter and the Philosopher's Stone",
    :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>
   {:title=>"Harry Potter and the Chamber of Secrets",
    :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>
   {:title=>"Harry Potter and the Prisoner of Azkaban",
    :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>
   {:title=>"Harry Potter and the Goblet of Fire", :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>
   {:title=>"Harry Potter and the Order of the Phoenix",
    :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>"Sofia"},
 {:item=>
   {:title=>"Harry Potter and the Half-Blood Prince", :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>
   {:title=>"Harry Potter and the Deathly Hallows", :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>"Martin"}]

--- Books in the Martin's library ---
# martin_library.list_of_books
[{:item=>{:title=>"A Game of Thrones", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>{:title=>"A Clash of Kings", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>{:title=>"A Storm of Swords", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>{:title=>"A Feast for Crows", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>{:title=>"A Dance with Dragons", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>{:title=>"The Winds of Winter", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>{:title=>"A Dream of Spring", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil}]

--- Search "Fire" ---
# rowling_library.search(title: 'Fire')
[{:item=>
   {:title=>"Harry Potter and the Goblet of Fire", :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil}]

--- Search "of" ---
# martin_library.search(title: 'of')
[{:item=>{:title=>"A Game of Thrones", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>{:title=>"A Clash of Kings", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>{:title=>"A Storm of Swords", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>{:title=>"The Winds of Winter", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>{:title=>"A Dream of Spring", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil}]

--- Sofia borrows "Harry Potter and the Goblet of Fire" ---
# sofia.borrow_book(title: 'Harry Potter and the Goblet of Fire', library: rowling_library)
"success"

--- Sofia borrows "Harry Potter and the Order of the Phoenix" ---
# sofia.borrow_book(title: 'Harry Potter and the Order of the Phoenix', library: rowling_library)
"success"

--- Sofia borrows "A Storm of Swords" ---
# sofia.borrow_book(title: 'A Storm of Swords', library: martin_library)
"success"

--- Martin borrows "Harry Potter and the Deathly Hallows" ---
# martin.borrow_book(title: 'Harry Potter and the Deathly Hallows', library: rowling_library)
"success"

--- Sofia's books ---
# sofia.books
[{:title=>"Harry Potter and the Goblet of Fire",
  :author=>"J.K. Rowling",
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>},
 {:title=>"Harry Potter and the Order of the Phoenix",
  :author=>"J.K. Rowling",
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>},
 {:title=>"A Storm of Swords",
  :author=>"George R. R. Martin",
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>}]

--- Martin's books ---
# martin.books
[{:title=>"Harry Potter and the Deathly Hallows",
  :author=>"J.K. Rowling",
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>}]

--- Sofia borrows "Harry Potter and the Goblet of Fire" again ---
# sofia.borrow_book(title: 'Harry Potter and the Goblet of Fire', library: rowling_library)
"not available"

--- Sofia borrows "Harry Potter and the Deathly Hallows" which was borrowed by Martin ---
# sofia.borrow_book(title: 'Harry Potter and the Deathly Hallows', library: rowling_library)
"not available"

--- Sofia borrows "Men without Women" which does not exist ---
# sofia.borrow_book(title: 'Men without Women', library: rowling_library)
"not found"

--- Sofia's books ---
# sofia.books
[{:title=>"Harry Potter and the Goblet of Fire",
  :author=>"J.K. Rowling",
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>},
 {:title=>"Harry Potter and the Order of the Phoenix",
  :author=>"J.K. Rowling",
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>},
 {:title=>"A Storm of Swords",
  :author=>"George R. R. Martin",
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>}]

--- Books in the Rowling's library ---
# rowling_library.list_of_books
[{:item=>
   {:title=>"Harry Potter and the Philosopher's Stone",
    :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>
   {:title=>"Harry Potter and the Chamber of Secrets",
    :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>
   {:title=>"Harry Potter and the Prisoner of Azkaban",
    :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>
   {:title=>"Harry Potter and the Goblet of Fire", :author=>"J.K. Rowling"},
  :available=>false,
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>,
  :borrower_name=>"Sofia"},
 {:item=>
   {:title=>"Harry Potter and the Order of the Phoenix",
    :author=>"J.K. Rowling"},
  :available=>false,
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>,
  :borrower_name=>"Sofia"},
 {:item=>
   {:title=>"Harry Potter and the Half-Blood Prince", :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>
   {:title=>"Harry Potter and the Deathly Hallows", :author=>"J.K. Rowling"},
  :available=>false,
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>,
  :borrower_name=>"Martin"}]

--- Books in the Martin's library ---
# martin_library.list_of_books
[{:item=>{:title=>"A Game of Thrones", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>{:title=>"A Clash of Kings", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>{:title=>"A Storm of Swords", :author=>"George R. R. Martin"},
  :available=>false,
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>,
  :borrower_name=>"Sofia"},
 {:item=>{:title=>"A Feast for Crows", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>{:title=>"A Dance with Dragons", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>{:title=>"The Winds of Winter", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>{:title=>"A Dream of Spring", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil}]

--- Martin returns "Harry Potter and the Goblet of Fire" which is not borrowed by him ---
# martin.return_book(title: 'Harry Potter and the Goblet of Fire', library: rowling_library)
"not borrowed"

--- Martin returns "Harry Potter and the Half-Blood Prince" which is available in library ---
# martin.return_book(title: 'Harry Potter and the Half-Blood Prince', library: rowling_library)
"not borrowed"

--- Sofia returns "Harry Potter and the Goblet of Fire" which is borrowed by her ---
# sofia.return_book(title: 'Harry Potter and the Goblet of Fire', library: rowling_library)
"success"

--- Sofia returns "A Dance with Dragons" which is not borrowed by her ---
# sofia.return_book(title: 'A Dance with Dragons', library: martin_library)
"not borrowed"

--- Sofia's books ---
# sofia.books
[{:title=>"Harry Potter and the Order of the Phoenix",
  :author=>"J.K. Rowling",
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>},
 {:title=>"A Storm of Swords",
  :author=>"George R. R. Martin",
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>}]

--- Martin's books ---
# martin.books
[{:title=>"Harry Potter and the Deathly Hallows",
  :author=>"J.K. Rowling",
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>}]

--- Books in the Rowling's library ---
# rowling_library.list_of_books
[{:item=>
   {:title=>"Harry Potter and the Philosopher's Stone",
    :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>
   {:title=>"Harry Potter and the Chamber of Secrets",
    :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>
   {:title=>"Harry Potter and the Prisoner of Azkaban",
    :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>
   {:title=>"Harry Potter and the Goblet of Fire", :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>
   {:title=>"Harry Potter and the Order of the Phoenix",
    :author=>"J.K. Rowling"},
  :available=>false,
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>,
  :borrower_name=>"Sofia"},
 {:item=>
   {:title=>"Harry Potter and the Half-Blood Prince", :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>
   {:title=>"Harry Potter and the Deathly Hallows", :author=>"J.K. Rowling"},
  :available=>false,
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>,
  :borrower_name=>"Martin"}]

--- Books in the Martin's library ---
# martin_library.list_of_books
[{:item=>{:title=>"A Game of Thrones", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>{:title=>"A Clash of Kings", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>{:title=>"A Storm of Swords", :author=>"George R. R. Martin"},
  :available=>false,
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>,
  :borrower_name=>"Sofia"},
 {:item=>{:title=>"A Feast for Crows", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>{:title=>"A Dance with Dragons", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>{:title=>"The Winds of Winter", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil},
 {:item=>{:title=>"A Dream of Spring", :author=>"George R. R. Martin"},
  :available=>true,
  :return_date=>nil,
  :borrower_name=>nil}]
```
