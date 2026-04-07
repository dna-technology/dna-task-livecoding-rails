class CreateUsersAndAccounts < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.timestamps
    end

    create_table :accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.float :balance # CRITICAL BUG: Float for currency
      t.timestamps
    end
  end
end
