require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @merchant = Merchant.new merchantId: "MERCHANTTESTID", name: "TESTNAME"
    @merchant.save
  end

  test "should not save user without a fullName" do
user = User.new userId: "TESTID", merchant_id: @merchant.id, email: "a@a"
    assert_not _user.save
  end

  test "should not save user without a merchantId" do
user = User.new fullName: "TESTNAME", merchant_id: @merchant.id, email: "a@a"
    assert_not _user.save
  end

  test "should not save user without an email" do
user = User.new userId: "TESTID", fullName: "TESTNAME", merchant_id: @merchant.id
    assert_not _user.save
  end

  test "should save user with a userId and a fullName and an email" do
user = User.new userId: "TESTID", fullName: "TESTNAME", merchant_id: @merchant.id, email: "a@a"
    assert _user.save
  end

  test "should create and save user with a random UUID as userId" do
user = User.create_with_uuid fullName: "TESTNAME", merchantId: @merchant.merchantId, email: "a@a"
    assert _user.persisted?
    assert_equal 36, _user.userId.length
  end
end
