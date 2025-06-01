require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "returns error, given email is duplicated" do
    user = User.new(email_address: users(:one).email_address, password: "password123", password_confirmation: "password123")
    refute user.save
    assert_includes user.errors[:email_address], "has already been taken"
  end
end
