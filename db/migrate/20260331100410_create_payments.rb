class CreatePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :payments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :merchant, null: false, foreign_key: true
      t.integer :amount_cents

      t.timestamps
    end
  end
end
