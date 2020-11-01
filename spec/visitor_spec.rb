require './lib/visitor.rb'

describe Visitor do
  let(:name) { "Reaksa" }
  let(:library) { instance_double('Library') }
  subject { Visitor.new(name) }

  before do
    not_available = { status: true, message: 'not available' }
    allow(library).to receive(:checkout).and_return(not_available)
    allow(library).to receive(:checkin).and_return(not_available)
  end

  it 'is expected to have a name on initialize' do
    expect(subject.name).to eq name
  end

  it 'is expected to have empty books list on initialize' do
    expect(subject.books).to eq []
  end

  describe "can borrow book as he" do
    it 'raises error if no library' do
      expect { subject.borrow_book({}) }.to raise_error("A library is required")
    end

    it 'raises error if no title' do
      expect { subject.borrow_book({library: library}) }.to raise_error("A title is required")
    end

    it 'returns message if given library and a title' do
      expect(subject.borrow_book(title: 'Title', library: library)).to be_an(String)
    end

    it 'calls checkout to library' do
      title = 'Title'
      expect(library).to receive(:checkout).with({title: title, visitor: subject})
      subject.borrow_book(title: title, library: library)
    end

    it 'updates his books upon success' do
      book = {
        title: 'Title',
        author: 'Author',
        return_date: Date.today.next_month(1)
      }
      expected_books = subject.books + [book]
      success = { status: true, message: 'success', book: book }
      allow(library).to receive(:checkout).with({title: book[:title], visitor: subject}).and_return(success)
      subject.borrow_book(title: book[:title], library: library)
      expect(subject.books).to eq expected_books
    end

    it 'does nothing to his books upon failure' do
      title = 'Title'
      expected_books = subject.books
      failure = { status: false, message: 'not available' }
      allow(library).to receive(:checkout).with({title: title, visitor: subject}).and_return(failure)
      subject.borrow_book(title: title, library: library)
      expect(subject.books).to eq expected_books
    end
  end

  describe "can return book as he" do
    it 'raises error if no library' do
      expect { subject.return_book({}) }.to raise_error("A library is required")
    end

    it 'raises error if no title' do
      expect { subject.return_book({library: library}) }.to raise_error("A title is required")
    end

    it 'returns message if given library and a title' do
      expect(subject.return_book(title: 'Title', library: library)).to be_an(String)
    end

    it 'calls checkin to library' do
      title = 'Title'
      expect(library).to receive(:checkin).with({title: title, visitor: subject})
      subject.return_book(title: title, library: library)
    end

    it 'updates his books upon success' do
      book = {
        title: 'Title',
        author: 'Author',
        return_date: Date.today.next_month(1)
      }
      subject.books = [book]
      success = { status: true, message: 'success', book: nil }
      allow(library).to receive(:checkin).with({title: book[:title], visitor: subject}).and_return(success)
      subject.return_book(title: book[:title], library: library)
      expect(subject.books).to eq []
    end

    it 'does nothing to his books upon failure' do
      title = 'Title'
      expected_books = subject.books
      failure = { status: false, message: 'not available' }
      allow(library).to receive(:checkin).with({title: title, visitor: subject}).and_return(failure)
      subject.borrow_book(title: title, library: library)
      expect(subject.books).to eq expected_books
    end
  end
end