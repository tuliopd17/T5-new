require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:admin)
  end

  test "should get login page" do
    get login_url
    assert_response :success
  end

  test "should create session with valid credentials" do
    post login_url, params: { 
      email: @user.email, 
      password: '123456' 
    }
    assert_redirected_to root_url
  end

  test "should destroy session" do
    # First login
    post login_url, params: { 
      email: @user.email, 
      password: '123456' 
    }
    
    # Then logout
    delete logout_url
    assert_redirected_to login_url
  end
end
