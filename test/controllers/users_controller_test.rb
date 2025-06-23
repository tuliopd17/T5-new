require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
    @normal_user = users(:user)
    log_in_as(@user) # Admin login for most tests
  end

  test "should get index as admin" do
    get users_url
    assert_response :success
  end

  test "should show user" do
    get user_url(@normal_user)
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@normal_user)
    assert_response :success
  end

  private

  def log_in_as(user)
    post login_url, params: { email: user.email, password: '123456' }
  end
end
