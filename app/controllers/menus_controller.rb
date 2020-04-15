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

  def new
    @user_role = @current_user.role
    render "new"
  end

  def destroy
    id = params[:id]
    menu = Menu.find(id)
    menu.destroy
    redirect_to new_menu_path
  end
end
