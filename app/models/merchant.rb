class Merchant < ApplicationRecord
  has_many :users
  has_many :payments

  validates :merchant_id, presence: true
  validates :name, presence: true

  before_validation(on: :create) { self.merchant_id = SecureRandom.uuid }

  def as_json(options = {})
    super(options.merge(except: [ :id, :created_at, :updated_at ]))
  end
end
