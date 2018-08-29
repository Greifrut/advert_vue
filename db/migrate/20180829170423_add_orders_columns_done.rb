class AddOrdersColumnsDone < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :done, :boolean, :default => false
    #Ex:- :default =>''
  end
end
