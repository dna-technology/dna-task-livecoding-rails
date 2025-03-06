require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @merchant = Merchant.new merchant_id: "MERCHANTTESTID", name: "TESTNAME"
    @merchant.save
  end

  test "should not create user without a full_name" do
    assert_no_difference("User.count") do
      post users_url, params: { merchant_id: @merchant.merchant_id, email: "a@a" }
    end

    assert_response 422
  end

  test "should not create user without a merchant_id" do
    assert_no_difference("User.count") do
      post users_url, params: { full_name: "TESTNAME", email: "a@a" }
    end

    assert_response 422
  end

  test "should not create user with non-existing merchant_id" do
    assert_no_difference("User.count") do
      post users_url, params: { full_name: "TESTNAME", merchant_id: @merchant.merchant_id+"THISMAKESTHISIDWRONG", email: "a@a" }
    end

    assert_response 422
  end

  test "should not create user without an email" do
    assert_no_difference("User.count") do
      post users_url, params: { full_name: "TESTNAME", merchant_id: @merchant.merchant_id }
    end

    assert_response 422
  end

  test "should create user with a full_name, merchant_id and an email" do
    assert_difference("User.count") do
      post users_url, params: { full_name: "TESTNAME", merchant_id: @merchant.merchant_id, email: "a@a" }
    end

    assert_response :success
  end
end
