class CreatePayments < ActiveRecord::Migration[8.1]
  def change
    create_table :payments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :merchant, null: false, foreign_key: true
      t.float :amount # INTERVIEWER NOTE: Float for currency is a CRITICAL BUG
      t.timestamps
    end
  end
end
