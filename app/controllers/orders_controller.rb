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
    order = Order.create!(
      date: Date.today,
      user_id: current_user.id,
      delivered_at: nil,
    )
    session[:current_order_id] = order.id
    redirect_to menu_items_path
  end

  def complete
    session[:current_order_id] = nil
    @current_order_id = nil
    redirect_to orders_path
  end

  def update
    id = params[:id]
    order = Order.find_by(id: id)
    order.update(delivered_at: Date.today)
    redirect_to orders_path
  end
end
