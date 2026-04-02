class MerchantSerializer
  def initialize(merchant)
    @merchant = merchant
  end

  def as_json(*)
    {
      merchant_id: @merchant.merchant_id,
      name: @merchant.name
    }
  end
end
