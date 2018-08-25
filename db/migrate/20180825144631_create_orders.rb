class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :owner_name
      t.integer :owner_phone
      t.integer :ad_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
