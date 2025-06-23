require "test_helper"

class AuthorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @author = authors(:one)
    @user = users(:admin)
    log_in_as(@user)
  end

  test "should get index" do
    get authors_url
    assert_response :success
  end

  test "should show author" do
    get author_url(@author)
    assert_response :success
  end

  test "should get new" do
    get new_author_url
    assert_response :success
  end

  test "should get edit" do
    get edit_author_url(@author)
    assert_response :success
  end

  private

  def log_in_as(user)
    post login_url, params: { email: user.email, password: '123456' }
  end
end
