require './lib/library.rb'

describe Library do
  let (:filepath) { 'any_filepath' }
  subject { Library.new(filepath) }

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
    allow(YAML).to receive(:load_file).with(filepath).and_return(books)
    library = Library.new filepath
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

  describe 'is expected for visitors to' do
    let (:name) { "Visitor" }
    let (:visitor) { Visitor.new(name) }

    describe 'checkout and get' do
      it 'an error if no title' do
        command = lambda { subject.checkout({}) }
        expect(command).to raise_error('A title is required')
      end

      it 'an error if no visitor' do
        command = lambda { subject.checkout({title: 'Title'}) }
        expect(command).to raise_error('A visitor is required')
      end

      it 'not found if title of book does not exist' do
        expected = { status: false, message: 'not found' }
        expect(subject.checkout(title: 'Title', visitor: visitor)).to eq expected
      end

      it 'not available if title of book is not available' do
        books[0][:available] = false
        books[0][:return_date] = Date.today.next_month(1)
        expected = { status: false, message: 'not available' }
        expect(subject.checkout(title: 'A Song of Ice and Fire', visitor: visitor)).to eq expected
      end

      it 'book as database is updated if title of book exists' do
        book = {
          title: book1[:item][:title],
          author: book1[:item][:author],
          return_date: Date.today.next_month(1)
        }
        expected = { status: true, message: 'success', book: book }
        expect(File).to receive(:open).with(filepath, 'w')
        expect(subject.checkout(title: 'A Song of Ice and Fire', visitor: visitor)).to eq expected
        expect(books[0][:available]).to eq false
        expect(books[0][:return_date]).to eq Date.today.next_month(1)
      end
    end

    describe 'checkin and get' do
      it 'an error if no title' do
        command = lambda { subject.checkin({}) }
        expect(command).to raise_error('A title is required')
      end

      it 'an error if no visitor' do
        command = lambda { subject.checkin({title: 'Title'}) }
        expect(command).to raise_error('A visitor is required')
      end

      it 'not found if title of book does not exist' do
        expected = { status: false, message: 'not found' }
        expect(subject.checkin(title: 'Title', visitor: visitor)).to eq expected
      end

      it 'not borrowed if title of book is not borrowed by him' do
        books[0][:available] = false
        books[0][:return_date] = Date.today.next_month(1)
        books[0][:borrower_name] = 'Unknown'
        expected = { status: false, message: 'not borrowed' }
        expect(subject.checkin(title: 'A Song of Ice and Fire', visitor: visitor)).to eq expected
        expect(subject.checkin(title: 'Harry Potter and the Goblet of Fire', visitor: visitor)).to eq expected
      end

      it 'success as database is updated if title of book is borrowed by him' do
        books[0][:available] = false
        books[0][:return_date] = Date.today.next_month(1)
        books[0][:borrower_name] = name
        expected = { status: true, message: 'success', book: nil }
        expect(File).to receive(:open).with(filepath, 'w')
        expect(subject.checkin(title: 'A Song of Ice and Fire', visitor: visitor)).to eq expected
        expect(subject.books[0][:available]).to eq true
        expect(subject.books[0][:return_date]).to eq nil
        expect(subject.books[0][:borrower_name]).to eq nil
      end
    end
  end

  it 'is able to reset all books to be available and save to database' do
    books[0][:available] = false
    books[0][:return_date] = Date.today.next_month(1)

    books[1][:available] = false
    books[2][:return_date] = Date.today.next_month(1)

    expect(File).to receive(:open).with(filepath, 'w')
    subject.reset

    expect(subject.books[0]).to eq ({
      item: books[0][:item],
      available: true,
      return_date: nil
    })

    expect(subject.books[1]).to eq ({
      item: books[1][:item],
      available: true,
      return_date: nil
    })
  end
end