class OrdersController < ApplicationController
  skip_before_action :ensure_admin_logged_in

  def index
    render "index"
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
end
