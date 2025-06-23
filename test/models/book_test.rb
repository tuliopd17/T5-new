require "test_helper"

class BookTest < ActiveSupport::TestCase
  def setup
    @book = books(:one)
  end

  test "should be valid" do
    assert @book.valid?
  end

  test "title should be present" do
    @book.title = "   "
    assert_not @book.valid?
  end

  test "isbn should be present" do
    @book.isbn = "   "
    assert_not @book.valid?
  end

  test "isbn should be unique" do
    duplicate_book = @book.dup
    @book.save
    assert_not duplicate_book.valid?
  end

  test "should belong to category" do
    @book.category = nil
    assert_not @book.valid?
  end

  test "should have many authors through book_authors" do
    assert_respond_to @book, :authors
    assert_respond_to @book, :book_authors
  end

  test "should have many loans" do
    assert_respond_to @book, :loans
  end

  test "available? should return false when book has active loans" do
    # O livro 'one' tem um empréstimo ativo na fixture
    assert_not @book.available?
  end
end
