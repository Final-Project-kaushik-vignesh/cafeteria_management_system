class AddItemValueToOrderItems < ActiveRecord::Migration[6.0]
  def change
    add_column :order_items, :item_value, :float
  end
end
