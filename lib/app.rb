require 'tty-prompt'
require './lib/library.rb'
require './lib/visitor.rb'

class App
  attr_reader :prompt, :sofia, :victor, :rowling, :martin

  def initialize
    @prompt = TTY::Prompt.new
    @sofia = Visitor.new("Sofia")
    @victor = Visitor.new("Victor")
    @rowling = Library.new('./lib/database/rowling_library.yml')
    @martin = Library.new('./lib/database/martin_library.yml')
  end

  def run
    rowling.reset
    martin.reset
    welcome
    while true do
      action = prompt.select("Option?") do |menu|
        menu.choice 'show'
        menu.choice 'search'
        menu.choice 'borrow a book', 'borrow'
        menu.choice 'return a book', 'return'
        menu.choice 'exit'
      end
      case action
      when "show"; show
      when "search"; search
      when "borrow"; borrow_book
      when "return"; return_book
      when "exit"; break
      end
      puts ""
    end
    puts "Bye!"
  end

  def welcome
    puts "💎 Welcome to Library App 💎"
    puts "  👉 2 vistors, Sofia and Vistor"
    puts "  👉 2 libraries, Rowling and Martin"
    puts "  👉 Search library's books by title"
    puts "  👉 Borrow an available book from a library for a visitor"
    puts "  👉 Return a borrowed book to a library for a visitor"
    puts "  👉 View a vistor, a library or everyone's books"
    puts ""
  end

  def show
    whose = prompt.select("Whose books?", %w(all sofia victor rowling martin debug))
    case whose
    when "all"
      puts "Sofia", sofia.books.map(&method(:pretty_visitor_book)), ""
      puts "Victor", victor.books.map(&method(:pretty_visitor_book)), ""
      puts "Rowling", rowling.list_of_books.map(&method(:pretty_library_book)), ""
      puts "Martin", martin.list_of_books.map(&method(:pretty_library_book)), ""
    when "sofia"
      puts sofia.books.map(&method(:pretty_visitor_book))
    when "victor"
      puts victor.books.map(&method(:pretty_visitor_book))
    when "rowling"
      puts rowling.list_of_books.map(&method(:pretty_library_book))
    when "martin"
      puts martin.list_of_books.map(&method(:pretty_library_book))
    when "debug"
      p "Sofia", sofia
      p "Victor", victor
      p "Rowling", rowling
      p "Martin", martin
    end
  end

  def search
    library = get_library("From?")
    title = prompt.ask("Title?")
    puts "searching title containing \"#{title}\" library..."
    puts pretty_search_result(library.search(title: title))
  end

  def borrow_book
    who = get_visitor("By?")
    library = get_library("From?")
    puts who.borrow_book(title: get_library_book_title(library), library: library)
  end

  def return_book
    visitor = get_visitor("By?")
    if no_book?(visitor.books) then
      puts "no borrowed book"
    else
      library = get_library("To?")
      puts visitor.return_book(title: get_visitor_book_title(visitor), library: library)
    end
  end

  def get_visitor title
    prompt.select(title) do |menu|
      menu.choice 'sofia', sofia
      menu.choice 'victor', victor
    end
  end

  def get_library title
    prompt.select(title) do |menu|
      menu.choice 'rowling', rowling
      menu.choice 'martin', martin
    end
  end

  def get_library_book_title library
    title = prompt.select("Choose a book?") do |menu|
      library.list_of_books.each do |book|
        menu.choice "#{book[:item][:title]} #{"[N/A]" if not book[:available]}", book[:item][:title]
      end
    end
  end

  def get_visitor_book_title visitor
    prompt.select("Choose a book?", visitor.books.map { |book| book[:title] })
  end

  def no_book? books
    books == []
  end

  def pretty_library_book book
    "- #{book[:item][:title]} by #{book[:item][:author]} #{"(borrowed by #{book[:borrower_name]}, returning before #{book[:return_date]})" if book[:borrower_name] != nil}"
  end

  def pretty_visitor_book book
    "- #{book[:title]} by #{book[:author]} (returning before #{book[:return_date]})"
  end

  def pretty_search_result result
    result == [] ? "not found" : result.map(&method(:pretty_library_book))
  end
end

app = App.new
app.run
