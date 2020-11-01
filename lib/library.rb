require 'yaml'
require 'date'

class Library
  LIBRARY_FILE = './lib/data.yml'

  attr_accessor :books

  def initialize
    @books = YAML.load_file(LIBRARY_FILE)
  end

  def search by
    books = @books
    if by[:title] != nil then
      books = search_book_title(by[:title], books)
    end
    if by[:author] != nil then
      books = search_book_author(by[:author], books)
    end
    if by[:title] == nil && by[:author] == nil then
      return []
    end
    return books
  end

  def list_of_books
    @books
  end

  def checkout(title)
    book = fetch_book(title)
    if found_book?(book) then
      return failure_payload('not found')
    elsif available_book?(book) then
      return failure_payload('not available')
    else
      checkout_book = perform_checkout(book)
      update_database
      return success_payload(checkout_book)
    end
  end

  def reset
    @books.each do |book|
      book[:available] = true
      book[:return_date] = nil
    end
    update_database
  end

  private

  def search_book_title(title, books)
    books.select { |book| book[:item][:title].include? title }
  end

  def search_book_author(author, books)
    books.select { |book| book[:item][:author].include? author }
  end

  def fetch_book(title)
    @books.detect { |book| book[:item][:title] == title }
  end

  def found_book?(book)
    book == nil
  end

  def available_book?(book)
    book[:available] == false
  end

  def failure_payload(message)
    { status: false, message: message }
  end

  def success_payload(book)
    { status: true, message: 'success', book: book }
  end

  def perform_checkout(book)
    book[:available] = false
    book[:return_date] = Date.today.next_month(1)
    {
      title: book[:item][:title],
      author: book[:item][:author],
      return_date: book[:return_date]
    }
  end

  def update_database
    File.open(LIBRARY_FILE, 'w') { |file| file.write(@books.to_yaml) }
  end
end
