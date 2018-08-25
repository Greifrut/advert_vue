class ChangeIntegerLimitInOrders < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :owner_phone, :integer, limit: 8
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
