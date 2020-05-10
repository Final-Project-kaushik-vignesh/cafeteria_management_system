class AdminController < ApplicationController
  skip_before_action :ensure_order_created

  def new
    render "new"
  end

  def create
    user = User.new(
      first_name: params[:first_name].capitalize,
      last_name: params[:last_name].capitalize,
      email: params[:email],
      password: params[:password],
      role: "clerk",
    )
    if user.valid?
      user.save
      redirect_to view_users_path
    else
      redirect_to new_admin_path
      flash[:errors] = user.errors
    end
  end

  def edit
    id = params[:id]
    @user = User.find_by(id: id)
    render "edit"
  end

  def view
    render "users"
  end

  def update
    id = params[:id]
    user = User.find_by(id: id)
    user.first_name = params[:first_name].capitalize
    user.last_name = params[:last_name].capitalize
    user.email = params[:email]
    if user.valid?
      user.save
      redirect_to view_users_path
    else
      redirect_to edit_admin_path
      flash[:errors] = user.errors
    end
  end

  def destroy
    id = params[:id]
    user = User.find_by(id: id)
    user.destroy
    redirect_to view_users_path
  end
end
