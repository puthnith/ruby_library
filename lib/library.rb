require 'yaml'
require 'date'

class Library
  attr_reader :filepath
  attr_accessor :books

  def initialize filepath
    @filepath = filepath
    @books = YAML.load_file(filepath)
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

  def checkout request
    assert_request_title(request)
    assert_request_visitor(request)
    book = fetch_book(request[:title])
    if found_book?(book) then
      return failure_payload('not found')
    elsif not_available_book?(book) then
      return failure_payload('not available')
    else
      checkout_book = perform_checkout(book, request[:visitor].name)
      update_database
      return success_payload(checkout_book)
    end
  end

  def checkin request
    assert_request_title(request)
    assert_request_visitor(request)
    book = fetch_book(request[:title])
    if found_book?(book) then
      return failure_payload('not found')
    elsif not_borrowed_book?(book, request[:visitor]) then
      return failure_payload('not borrowed')
    else
      checkout_book = perform_checkin(book)
      update_database
      return success_payload(nil)
    end
  end

  def reset
    @books.each do |book|
      book[:available] = true
      book[:return_date] = nil
      book[:borrower_name] = nil
    end
    update_database
  end

  private

  def search_book_title(title, books)
    books.select { |book| book[:item][:title].downcase.include? title.downcase }
  end

  def search_book_author(author, books)
    books.select { |book| book[:item][:author].downcase.include? author.downcase }
  end

  def assert_request_title request
    raise "A title is required" if not request[:title]
  end

  def assert_request_visitor request
    raise "A visitor is required" if not request[:visitor]
  end

  def fetch_book(title)
    @books.detect { |book| book[:item][:title] == title }
  end

  def found_book?(book)
    book == nil
  end

  def not_available_book?(book)
    book[:available] == false
  end

  def not_borrowed_book?(book, visitor)
    book[:available] || book[:borrower_name] != visitor.name
  end

  def failure_payload(message)
    { status: false, message: message }
  end

  def success_payload(book)
    { status: true, message: 'success', book: book }
  end

  def perform_checkout(book, name)
    book[:available] = false
    book[:return_date] = Date.today.next_month(1)
    book[:borrower_name] = name
    {
      title: book[:item][:title],
      author: book[:item][:author],
      return_date: book[:return_date]
    }
  end

  def perform_checkin(book)
    book[:available] = true
    book[:return_date] = nil
    book[:borrower_name] = nil
  end

  def update_database
    File.open(filepath, 'w') { |file| file.write(@books.to_yaml) }
  end
end
