class UsersController < ApplicationController
  def new
  end

  def create
    user = User.create!(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
      role: "customer",
    )
    session[:current_user_id] = user.id
    redirect_to "/"
  end
end
