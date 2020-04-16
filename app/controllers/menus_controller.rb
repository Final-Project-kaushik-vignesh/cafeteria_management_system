class MenusController < ApplicationController
  def index
    @user_role = @current_user.role
    render "index"
  end

  def create
    menu = Menu.create!(
      name: params[:name].capitalize,
    )

    redirect_to menus_path
  end

  def destroy
    id = params[:id]
    MenuItem.all.where(menu_id: id).destroy_all
    menu = Menu.find(id)
    menu.destroy
    redirect_to menus_path
  end

  def edit
    session[:current_menu_id] = params[:id]
    render "edit"
  end
end
