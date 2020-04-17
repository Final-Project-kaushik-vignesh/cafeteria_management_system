class ApplicationController < ActionController::Base
  before_action :ensure_user_logged_in
  before_action :ensure_admin_logged_in
  before_action :ensure_order_created

  def ensure_admin_logged_in
    current_user_role = @current_user.role

    unless current_user_role == "owner"
      redirect_to "/"
    end
  end

  def ensure_user_logged_in
    unless current_user
      redirect_to "/"
    end
  end

  def ensure_order_created
    unless current_order_id
      redirect_to "/"
    end
  end

  def current_menu_id
    @current_menu_id = session[:current_menu_id]
  end

  def current_order_id
    return @current_order_id if @current_order_id
    @current_order_id = session[:current_order_id]
  end

  def current_user
    return @current_user if @current_user
    current_user_id = session[:current_user_id]
    if current_user_id
      @current_user = User.find(current_user_id)
    else
      nil
    end
  end
end
