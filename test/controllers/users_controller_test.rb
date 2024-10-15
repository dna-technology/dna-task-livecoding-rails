require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @merchant = Merchant.new merchantId: "MERCHANTTESTID", name: "TESTNAME"
    @merchant.save
  end

  test "should not create user without a fullName" do
    assert_no_difference("User.count") do
      post users_url, params: { merchantId: @merchant.merchantId, email: "a@a" }
    end

    assert_response 422
  end

  test "should not create user without a merchantId" do
    assert_no_difference("User.count") do
      post users_url, params: { fullName: "TESTNAME", email: "a@a" }
    end

    assert_response 422
  end

  test "should not create user with non-existing merchantId" do
    assert_no_difference("User.count") do
      post users_url, params: { fullName: "TESTNAME", merchantId: @merchant.merchantId+"THISMAKESTHISIDWRONG", email: "a@a" }
    end

    assert_response 422
  end

  test "should not create user without an email" do
    assert_no_difference("User.count") do
      post users_url, params: { fullName: "TESTNAME", merchantId: @merchant.merchantId }
    end

    assert_response 422
  end

  test "should create user with a fullName, merchantId and an email" do
    assert_difference("User.count") do
      post users_url, params: { fullName: "TESTNAME", merchantId: @merchant.merchantId, email: "a@a" }
    end

    assert_response :success
  end
end
