class CreateAds < ActiveRecord::Migration[5.2]
  def change
    create_table :ads do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.boolean :promo, default: false

      t.timestamps
    end
  end
end
