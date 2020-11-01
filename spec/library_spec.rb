require './lib/library.rb'

describe Library do
  let (:book1) {
    {
      item: {
        title: 'A Song of Ice and Fire',
        author: 'George R. R. Martin'
      },
      available: true,
      return_date: nil
    }
  }

  let (:book2) {
    {
      item: {
        title: 'Harry Potter and the Goblet of Fire',
        author: 'J.K. Rowling'
      },
      available: true,
      return_date: nil
    }
  }

  let (:book3) {
    {
      item: {
        title: 'Harry Potter and the Prisoner of Azkaban',
        author: 'J.K. Rowling'
      },
      available: true,
      return_date: nil
    }
  }

  let (:books) { [book1, book2, book3] }

  before do
    allow(File).to receive(:open)
    # 👆 this allow forbidden `YAML.load_file()` to load real
    #    file because, it also uses `File.open` under the hook.
    #    Thus, we don't need to stub `allow(YAML).to receive(:load_file)`

    subject.books = books
  end

  it 'is expected to load books from YAML file on initialized' do
    allow(YAML).to receive(:load_file).with(Library::LIBRARY_FILE).and_return(books)
    library = Library.new
    expect(library.books).to eq books
  end

  it 'is able to search books by titles' do
    result = subject.search({title: 'Azkaban'})
    expect(result).to eq [book3]
  end

  it 'is able to search books by authors' do
    result = subject.search({author: 'Martin'})
    expect(result).to eq [book1]
  end

  it 'is able to search books by titles and authors' do
    result = subject.search({title: 'Fire', author: 'Rowling'})
    expect(result).to eq [book2]
  end

  it 'returns empty array if no title or author provided to search' do
    result = subject.search({})
    expect(result).to eq []
  end

  it 'is expected to provide a list of books to visitors' do
    expect(subject.list_of_books).to eq books
  end

  it 'is expected to return not found if title of book does not exist' do
    expected = { status: false, message: 'not found' }
    expect(subject.checkout('Title')).to eq expected
  end

  it 'is expected to return not available if title of book is not available' do
    book1[:available] = false
    subject.books[0][:return_date] = Date.today.next_month(1)
    expected = { status: false, message: 'not available' }
    expect(subject.checkout('A Song of Ice and Fire')).to eq expected
  end

  it 'is expected to return book and update database if title of book exists' do
    book = {
      title: book1[:item][:title],
      author: book1[:item][:author],
      return_date: Date.today.next_month(1)
    }
    expected = { status: true, message: 'success', book: book }

    expect(File).to receive(:open).with(Library::LIBRARY_FILE, 'w')
    expect(subject.checkout('A Song of Ice and Fire')).to eq expected
    expect(subject.books[0][:available]).to eq false
    expect(subject.books[0][:return_date]).to eq Date.today.next_month(1)

  end

  it 'is able to reset all books to be available and save to database' do
    subject.books[0][:available] = false
    subject.books[0][:return_date] = Date.today.next_month(1)

    subject.books[1][:available] = false
    subject.books[2][:return_date] = Date.today.next_month(1)

    expect(File).to receive(:open).with(Library::LIBRARY_FILE, 'w')
    subject.reset

    expect(subject.books[0]).to eq ({
      item: subject.books[0][:item],
      available: true,
      return_date: nil
    })

    expect(subject.books[1]).to eq ({
      item: subject.books[1][:item],
      available: true,
      return_date: nil
    })
  end
end