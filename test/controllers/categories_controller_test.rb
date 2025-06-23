require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = categories(:fiction)
    @user = users(:admin)
    log_in_as(@user)
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  test "should get new" do
    get new_category_url
    assert_response :success
  end

  test "should get edit" do
    get edit_category_url(@category)
    assert_response :success
  end

  private

  def log_in_as(user)
    post login_url, params: { email: user.email, password: '123456' }
  end
end
