class MenusController < ApplicationController
  def index
    @user_role = @current_user.role
    render "index"
  end

  def create
    Menu.create!(
      name: params[:name].capitalize,
    )
    redirect_to new_menu_path
  end
end
