require "test_helper"

class MerchantTest < ActiveSupport::TestCase
  test "should not save merchant without a name" do
    merchant = Merchant.new merchant_id: "TESTID"
    assert_not merchant.save
  end

  test "should save merchant with a merchant_id and a name" do
    merchant = Merchant.new merchant_id: "TESTID", name: "TESTNAME"
    assert merchant.save
  end

  test "should auto-generate a UUID merchant_id on create" do
    merchant = Merchant.create! name: "TESTNAME"
    assert merchant.persisted?
    assert_equal 36, merchant.merchant_id.length
  end
end
