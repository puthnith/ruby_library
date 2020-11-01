require 'date'

class Visitor
  attr_accessor :name, :books

  def initialize name
    @name = name
    @books = []
  end

  def borrow args
    library = assert_library(args[:library])
    title = assert_items(args[:title])
    result = library.checkout(title: title, visitor: self)
    if result[:status] then
      @books << result[:book]
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
