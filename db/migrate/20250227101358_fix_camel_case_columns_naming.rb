class FixCamelCaseColumnsNaming < ActiveRecord::Migration[7.2]
  def change
    rename_column :accounts, :accountId, :account_id
    rename_column :merchants, :merchantId, :merchant_id
    rename_column :payments, :paymentId, :payment_id
    rename_column :users, :userId, :user_id
    rename_column :users, :fullName, :full_name
  end
end
