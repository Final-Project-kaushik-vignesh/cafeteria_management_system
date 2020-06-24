class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in
  skip_before_action :ensure_admin_logged_in
  skip_before_action :ensure_order_created

  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:current_user_id] = user.id
      redirect_to "/"
    else
      flash[:error] = "Your login attempt is Invalid. Please retry"
      redirect_to new_sessions_path, warning: "Invalid User Id or Password"
    end
  end

  def destroy
    if session[:current_order_id]
      order = Order.find_by(id: current_order_id)
      order_item = OrderItem.all.where(order_id: @current_order_id)
      order_item.destroy_all
      order.destroy
    end
    session[:current_user_id] = nil
    session[:current_order_id] = nil
    @current_order_id = nil
    @current_user = nil
    redirect_to "/"
  end
end
