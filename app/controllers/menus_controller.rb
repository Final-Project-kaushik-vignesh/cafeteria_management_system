class MenusController < ApplicationController
  def index
    @user_role = @current_user.role
    render "index"
  end

  def create
    menu = Menu.create!(
      name: params[:name].capitalize,
      Active_Menu: false,
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
    @current_menu_id = session[:current_menu_id]
    render "edit"
  end

  def update
    Menu.all.each { |menu| menu.update(Active_Menu: false) }
    id = params[:id]
    menu = Menu.find_by(id: id)
    menu.update(Active_Menu: true)
    redirect_to menus_path
  end
end
