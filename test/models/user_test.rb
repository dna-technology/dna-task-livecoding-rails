require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @merchant = Merchant.new merchant_id: "MERCHANTTESTID", name: "TESTNAME"
    @merchant.save
  end

  test "should not save user without a full_name" do
    user = User.new user_id: "TESTID", merchant_id: @merchant.id, email: "a@a"
    assert_not user.save
  end

  test "should not save user without a merchant_id" do
    user = User.new full_name: "TESTNAME", merchant_id: @merchant.id, email: "a@a"
    assert_not user.save
  end

  test "should not save user without an email" do
    user = User.new user_id: "TESTID", full_name: "TESTNAME", merchant_id: @merchant.id
    assert_not user.save
  end

  test "should save user with a user_id and a full_name and an email" do
    user = User.new user_id: "TESTID", full_name: "TESTNAME", merchant_id: @merchant.id, email: "a@a"
    assert user.save
  end

  test "should create and save user with a random UUID as user_id" do
    user = User.create_with_uuid_and_account full_name: "TESTNAME", merchant_id: @merchant.merchant_id, email: "a@a"
    assert user.persisted?
    assert_equal 36, user.user_id.length
  end
end
