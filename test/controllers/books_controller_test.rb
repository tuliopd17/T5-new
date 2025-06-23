require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)
    @user = users(:admin)
    log_in_as(@user)
  end

  test "should get index" do
    get books_url
    assert_response :success
  end

  test "should show book" do
    get book_url(@book)
    assert_response :success
  end

  test "should get new" do
    get new_book_url
    assert_response :success
  end

  test "should create book" do
    assert_difference('Book.count') do
      post books_url, params: { 
        book: { 
          title: "New Test Book", 
          isbn: "978-1111111111",
          publication_date: Date.current,
          pages: 200,
          description: "Test description",
          category_id: categories(:fiction).id
        } 
      }
    end

    assert_redirected_to book_url(Book.last)
  end

  test "should get edit" do
    get edit_book_url(@book)
    assert_response :success
  end

  test "should update book" do
    patch book_url(@book), params: { 
      book: { 
        title: "Updated Test Book"
      } 
    }
    assert_redirected_to book_url(@book)
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete book_url(@book)
    end

    assert_redirected_to books_url
  end

  private

  def log_in_as(user)
    post login_url, params: { email: user.email, password: '123456' }
  end
end
