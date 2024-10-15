class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :userId
      t.string :fullName
      t.string :email
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
