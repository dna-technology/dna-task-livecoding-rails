class FixCamelCaseColumnsNaming < ActiveRecord::Migration[7.2]
  def change
    rename_column :accounts, :accountId, :account_id
    rename_column :merchants, :merchantId, :merchant_id
    rename_column :payments, :paymentId, :payment_id
    rename_column :users, :user_id, :user_id
    rename_column :users, :full_name, :full_name
  end
end
