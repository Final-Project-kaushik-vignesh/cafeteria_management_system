class MenuItemsController < ApplicationController
  skip_before_action :ensure_admin_logged_in

  def index
    active_menu = Menu.find_by(active_menu: true)
    @menu_item = MenuItem.of_menu(active_menu)
    @order_items = OrderItem.all.where(order_id: current_order_id)
  end

  def update
    id = params[:id]
    order_item = OrderItem.find_by(id: id)
    order_item.update(quantity: params[:quantity])
    order_item.update(item_value: order_item.menu_item.price * params[:quantity].to_f)
    order = Order.find_by(id: current_order_id)
    order_items = OrderItem.all.where(order_id: order.id)
    total_price = order_items.sum(:item_value)
    order.update(total_price: total_price)
    redirect_to menu_items_path
  end

  def destroy
    id = params[:id]
    order_item = OrderItem.find(id)
    order_item.destroy
    order = Order.find_by(id: current_order_id)
    order_items = OrderItem.all.where(order_id: order.id)
    total_price = order_items.sum(:item_value)
    order.update(total_price: total_price)
    redirect_to menu_items_path
  end
end
