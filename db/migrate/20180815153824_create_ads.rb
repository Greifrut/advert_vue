class CreateAds < ActiveRecord::Migration[5.2]
  def change
    create_table :ads do |t|
      t.string :title
      t.string :description
      t.boolean :promo

      t.timestamps
    end
  end
end
