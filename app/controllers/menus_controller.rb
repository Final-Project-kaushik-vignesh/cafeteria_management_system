class MenusController < ApplicationController
  def index
    @user_role = @current_user.role
    render "index"
  end

  def create
    Menu.create!(
      name: params[:name].capitalize,
    )
  end
end
