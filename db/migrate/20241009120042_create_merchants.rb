class CreateMerchants < ActiveRecord::Migration[7.2]
  def change
    create_table :merchants do |t|
      t.string :merchantId
      t.string :name

      t.timestamps
    end
  end
end
