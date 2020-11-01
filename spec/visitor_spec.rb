require './lib/visitor.rb'

describe Visitor do
  let(:library) { instance_double('Library') }
  subject { Visitor.new }

  before do
    not_available = { status: false, message: 'not available' }
    allow(library).to receive(:checkout).and_return(not_available)
  end

  it 'is expected to have empty books list on initialize' do
    expect(subject.books).to eq []
  end

  it 'is expected to raise error if no library' do
    expect { subject.borrow({}) }.to raise_error("A library is required")
  end

  it 'is expected to raise error if no title' do
    expect { subject.borrow({library: library}) }.to raise_error("A title is required")
  end

  it 'is expected to return message if given library and a title' do
    expect(subject.borrow(title: 'Title', library: library)).to be_an(String)
  end

  it 'is expected to call :checkout from library' do
    title = 'Title'
    expect(library).to receive(:checkout).with(title)
    subject.borrow(title: title, library: library)
  end

  it 'is expected to update the visitor\'s books upon success' do
    book = {
      title: "Title",
      author: "Author",
      return_date: Date.today.next_month(1)
    }
    expected_books = subject.books + [book]
    success = { status: true, message: 'success', book: book }
    allow(library).to receive(:checkout).and_return(success)
    subject.borrow(title: book[:title], library: library)
    expect(subject.books).to eq expected_books
  end

  it 'is expected to do nothing to the visitor\'s books upon failure' do
    expected_books = subject.books
    failure = { status: false, message: 'not available' }
    allow(library).to receive(:checkout).and_return(failure)
    subject.borrow(title: 'Title', library: library)
    expect(subject.books).to eq expected_books
  end
end