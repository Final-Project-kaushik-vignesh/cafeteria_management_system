class AdminController < ApplicationController
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
end
