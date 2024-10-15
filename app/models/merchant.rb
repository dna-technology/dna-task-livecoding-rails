class Merchant < ApplicationRecord
  has_many :users
  has_many :payments

  validates :merchantId, presence: true
  validates :name, presence: true

  def self.create_with_uuid(attributes)
    merchant = new(attributes)
    merchant.merchantId = SecureRandom.uuid
    merchant.save!
    merchant
  end

  def as_json(options = {})
    super(options.merge(except: [ :id, :created_at, :updated_at ]))
  end
end
