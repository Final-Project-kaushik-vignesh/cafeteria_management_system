class OrderItemsController < ApplicationController
  def create
    menu_item = MenuItem.find_by(id: params[:menu_item_id])
    order_item = OrderItem.create!(
      order_id: nil,
      menu_item_id: menu_item.id,
      menu_item_name: menu_item.name,
      menu_item_price: menu_item.price,
      quantity: params[:quantity],
    )
  end
end
