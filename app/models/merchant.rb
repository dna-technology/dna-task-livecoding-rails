class Merchant < ApplicationRecord
  has_many :users
  has_many :payments

  validates :merchant_id, presence: true
  validates :name, presence: true

  def self.create_with_uuid(attributes)
    merchant = new(attributes)
    merchant.merchant_id = SecureRandom.uuid
    merchant.save!
    merchant
  end

  def as_json(options = {})
    super(options.merge(except: [ :id, :created_at, :updated_at ]))
  end
end
