class UpdateUserController < ApplicationController
  skip_before_action :ensure_order_created
  skip_before_action :ensure_admin_logged_in

  def index
    @user = User.find_by(id: @current_user.id)
    render "index"
  end

  def update
    user = User.find_by(id: @current_user.id)
    user.first_name = params[:first_name].capitalize
    user.last_name = params[:last_name].capitalize
    user.email = params[:email]
    user.password = params[:password]
    if user.valid?
      user.save
      redirect_to orders_path
    else
      redirect_to view_edit_user_path
      flash[:errors] = user.errors
    end
  end
end
