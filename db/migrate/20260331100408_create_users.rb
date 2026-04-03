class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :balance_cents

      t.timestamps
    end
  end
end
