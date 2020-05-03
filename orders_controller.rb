class OrdersController < ApplicationController
  skip_before_action :ensure_admin_logged_in
  skip_before_action :ensure_order_created

  def index
    if @current_user.role == "owner"
      @orders = Order.all
    elsif @current_user.role == "clerk"
      @orders = Order.clerk
    else
      @orders = current_user.orders
    end
  end

  def create
    if Menu.all.find_by(active_menu: true)
      order = Order.create!(
        date: Date.today,
        user_id: current_user.id,
        delivered_at: nil,
        total_price: 0,
      )
      session[:current_order_id] = order.id
      redirect_to menu_items_path
    else
      flash[:error] = "No Active Menu. Contact Admin"
      redirect_to orders_path
    end
  end

  def complete
    if OrderItem.find_by(order_id: current_order_id) == nil
      flash[:error] = "Empty Cart !!"
      redirect_to order_items_path
    else
      session[:current_order_id] = nil
      @current_order_id = nil
      flash[:alert] = "Order placed Successfully !!"
      redirect_to orders_path
    end
  end

  def update
    id = params[:id]
    order = Order.find_by(id: id)
    if (params[:delivered_at])
      order.update(delivered_at: DateTime.now)
    else
      order.update(delivered_at: nil)
    end
    redirect_to orders_path
  end

  def destroy
    id = params[:id]
    order = Order.find_by(id: id)
    order_item = OrderItem.all.where(order_id: id)
    order_item.destroy_all
    order.destroy
    session[:current_order_id] = nil
    @current_order_id = nil
    redirect_to orders_path
  end
end
