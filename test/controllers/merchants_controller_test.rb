require "test_helper"

class MerchantsControllerTest < ActionDispatch::IntegrationTest
  test "should not create merchant without a name" do
    assert_no_difference("Merchant.count") do
      post merchants_url, params: {}
    end

    assert_response 422
  end

  test "should create merchant with a name" do
    assert_difference("Merchant.count") do
      post merchants_url, params: { name: "TESTNAME" }
    end

    assert_response :success
  end
end
