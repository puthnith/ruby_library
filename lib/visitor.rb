require 'date'

class Visitor
  attr_accessor :name, :books

  def initialize name
    @name = name
    @books = []
  end

  def borrow_book args
    library = assert_library(args[:library])
    title = assert_items(args[:title])
    result = library.checkout(title: title, visitor: self)
    if result[:status] then
      @books << result[:book]
    end
    result[:message]
  end

  def return_book args
    library = assert_library(args[:library])
    title = assert_items(args[:title])
    result = library.checkin(title: title, visitor: self)
    if result[:status] then
      # @books.delete_at(@books.find_index { |book| book[:title] == title })
      @books = @books.reject { |book| book[:title] == title }
    end
    result[:message]
  end

  def assert_library library
    raise "A library is required" if not library
    library
  end

  def assert_items items
    raise "A title is required" if not items
    items
  end
end
