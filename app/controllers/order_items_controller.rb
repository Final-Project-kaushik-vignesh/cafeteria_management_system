class OrderItemsController < ApplicationController
  skip_before_action :ensure_admin_logged_in

  def create
    menu_item = MenuItem.find_by(id: params[:menu_item_id])
    order_item = OrderItem.create!(
      order_id: current_order_id,
      menu_item_id: menu_item.id,
      menu_item_name: menu_item.name,
      menu_item_price: menu_item.price,
      quantity: params[:quantity],
    )
    redirect_to menu_items_path
  end

  def index
  end
end
