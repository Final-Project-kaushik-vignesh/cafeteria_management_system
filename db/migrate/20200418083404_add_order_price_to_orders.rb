class AddOrderPriceToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :order_price, :float
  end
end
