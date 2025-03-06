require "test_helper"

class MerchantTest < ActiveSupport::TestCase
  test "should not save merchant without a name" do
    merchant = Merchant.new merchant_id: "TESTID"
    assert_not merchant.save
  end

  test "should not save merchant without a merchant_id" do
    merchant = Merchant.new name: "TESTNAME"
    assert_not merchant.save
  end

  test "should save merchant with a merchant_id and a name" do
    merchant = Merchant.new merchant_id: "TESTID", name: "TESTNAME"
    assert merchant.save
  end

  test "should create and save merchant with a random UUID as merchant_id" do
    merchant = Merchant.create_with_uuid name: "TESTNAME"
    assert merchant.persisted?
    assert_equal 36, merchant.merchant_id.length
  end
end
