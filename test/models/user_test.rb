require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @merchant = Merchant.new merchantId: "MERCHANTTESTID", name: "TESTNAME"
    @merchant.save
  end

  test "should not save user without a fullName" do
    user = User.new userId: "TESTID", merchant_id: @merchant.id, email: "a@a"
    assert_not user.save
  end

  test "should not save user without a merchantId" do
    user = User.new fullName: "TESTNAME", merchant_id: @merchant.id, email: "a@a"
    assert_not user.save
  end

  test "should not save user without an email" do
    user = User.new userId: "TESTID", fullName: "TESTNAME", merchant_id: @merchant.id
    assert_not user.save
  end

  test "should save user with a userId and a fullName and an email" do
    user = User.new userId: "TESTID", fullName: "TESTNAME", merchant_id: @merchant.id, email: "a@a"
    assert user.save
  end

  test "should create and save user with a random UUID as userId" do 
    user = User.create_with_uuid_and_account fullName: "TESTNAME", merchantId: @merchant.merchantId, email: "a@a"
    assert user.persisted?
    assert_equal 36, user.userId.length
  end
end
