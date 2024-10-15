require "test_helper"

class MerchantTest < ActiveSupport::TestCase
  test "should not save merchant without a name" do
    merchant = Merchant.new merchantId: "TESTID"
    assert_not merchant.save
  end

  test "should not save merchant without a merchantId" do
    merchant = Merchant.new name: "TESTNAME"
    assert_not merchant.save
  end

  test "should save merchant with a merchantId and a name" do
    merchant = Merchant.new merchantId: "TESTID", name: "TESTNAME"
    assert merchant.save
  end

  test "should create and save merchant with a random UUID as merchantId" do
    merchant = Merchant.create_with_uuid name: "TESTNAME"
    assert merchant.persisted?
    assert_equal 36, merchant.merchantId.length
  end
end
