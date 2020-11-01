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
  is expected to return not found if title of book does not exist
  is expected to return not available if title of book is not available
  is expected to return book and update database if title of book exists
  is able to reset all books to be available and save to database

Visitor
  is expected to have empty books list on initialize
  is expected to raise error if no library
  is expected to raise error if no title
  is expected to return message if given library and a title
  is expected to call :checkout from library
  is expected to update the visitor's books upon success
  is expected to do nothing to the visitor's books upon failure

Finished in 0.03219 seconds (files took 0.15021 seconds to load)
17 examples, 0 failures
```

## Simulation

```none
💎 ruby './lib/index.rb'

--- Books in the library ---
# library.list_of_books
[{:item=>
   {:title=>"Harry Potter and the Philosopher's Stone",
    :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil},
 {:item=>
   {:title=>"Harry Potter and the Chamber of Secrets",
    :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil},
 {:item=>
   {:title=>"Harry Potter and the Prisoner of Azkaban",
    :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil},
 {:item=>
   {:title=>"Harry Potter and the Goblet of Fire", :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil},
 {:item=>
   {:title=>"Harry Potter and the Order of the Phoenix",
    :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil},
 {:item=>
   {:title=>"Harry Potter and the Half-Blood Prince", :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil},
 {:item=>
   {:title=>"Harry Potter and the Deathly Hallows", :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil}]

--- Visitor's books ---
# visitor.books
[]

--- Search "Fire" ---
# library.search(title: "Fire")
[{:item=>
   {:title=>"Harry Potter and the Goblet of Fire", :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil}]

--- Visitor borrows "Harry Potter and the Goblet of Fire" ---
# visitor.borrow(title: "Harry Potter and the Goblet of Fire", library: library)
"success"

--- Visitor borrows "Harry Potter and the Order of the Phoenix" ---
# visitor.borrow(title: "Harry Potter and the Order of the Phoenix", library: library)
"success"

--- Visitor's books ---
# visitor.books
[{:title=>"Harry Potter and the Goblet of Fire",
  :author=>"J.K. Rowling",
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>},
 {:title=>"Harry Potter and the Order of the Phoenix",
  :author=>"J.K. Rowling",
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>}]

--- Visitor borrows "Harry Potter and the Goblet of Fire" again ---
# visitor.borrow(title: "Harry Potter and the Goblet of Fire", library: library)
"not available"

--- Visitor borrows "Men without Women" ---
# visitor.borrow(title: "Men without Women", library: library)
"not found"

--- Visitor's books ---
# visitor.books
[{:title=>"Harry Potter and the Goblet of Fire",
  :author=>"J.K. Rowling",
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>},
 {:title=>"Harry Potter and the Order of the Phoenix",
  :author=>"J.K. Rowling",
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>}]

--- Books in the library ---
# library.list_of_books
[{:item=>
   {:title=>"Harry Potter and the Philosopher's Stone",
    :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil},
 {:item=>
   {:title=>"Harry Potter and the Chamber of Secrets",
    :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil},
 {:item=>
   {:title=>"Harry Potter and the Prisoner of Azkaban",
    :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil},
 {:item=>
   {:title=>"Harry Potter and the Goblet of Fire", :author=>"J.K. Rowling"},
  :available=>false,
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>},
 {:item=>
   {:title=>"Harry Potter and the Order of the Phoenix",
    :author=>"J.K. Rowling"},
  :available=>false,
  :return_date=>#<Date: 2020-12-01 ((2459185j,0s,0n),+0s,2299161j)>},
 {:item=>
   {:title=>"Harry Potter and the Half-Blood Prince", :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil},
 {:item=>
   {:title=>"Harry Potter and the Deathly Hallows", :author=>"J.K. Rowling"},
  :available=>true,
  :return_date=>nil}]
```
