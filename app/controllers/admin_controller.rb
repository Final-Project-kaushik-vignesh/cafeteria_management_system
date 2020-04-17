class AdminController < ApplicationController
  skip_before_action :ensure_order_created

  def new
    render "new"
  end

  def create
    user = User.create!(
      first_name: params[:first_name].capitalize,
      last_name: params[:last_name].capitalize,
      email: params[:email],
      password: params[:password],
      role: "clerk",
    )
    redirect_to admin_index_path
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
    user.update(
      first_name: params[:first_name].capitalize,
      last_name: params[:last_name].capitalize,
      email: params[:email],
      password: params[:password],
      role: "clerk",
    )
    redirect_to view_users_path
  end

  def destroy
    id = params[:id]
    user = User.find_by(id: id)
    user.destroy
    redirect_to view_users_path
  end
end
