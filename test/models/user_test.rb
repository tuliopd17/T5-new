require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:admin)
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "email should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "role should be admin or user" do
    @user.role = "invalid"
    assert_not @user.valid?
    
    @user.role = "admin"
    assert @user.valid?
    
    @user.role = "user"
    assert @user.valid?
  end

  test "admin? should return true for admin users" do
    @user.role = "admin"
    assert @user.admin?
  end

  test "user? should return true for regular users" do
    @user.role = "user"
    assert @user.user?
  end

  test "should have secure password" do
    @user.password = @user.password_confirmation = "123456"
    assert @user.authenticate("123456")
    assert_not @user.authenticate("wrong")
  end
end
