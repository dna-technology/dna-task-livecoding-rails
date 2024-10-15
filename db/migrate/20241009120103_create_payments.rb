class CreatePayments < ActiveRecord::Migration[7.2]
  def change
    create_table :payments do |t|
      t.string :paymentId
      t.references :user, null: false, foreign_key: true
      t.references :merchant, null: false, foreign_key: true
      t.float :amount

      t.timestamps
    end
  end
end
