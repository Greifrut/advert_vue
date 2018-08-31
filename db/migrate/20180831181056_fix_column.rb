class FixColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :owner_name, :purchaser_name
    rename_column :orders, :onwer_phone, :purchaser_phone
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
