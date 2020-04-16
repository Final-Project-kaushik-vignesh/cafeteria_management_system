class MenuItemsController < ApplicationController
  skip_before_action :ensure_admin_logged_in

  def index
    active_menu = Menu.find_by(Active_Menu: true)
    @menu_item = MenuItem.of_menu(active_menu)
  end

  def create
    menu_item = MenuItem.create!(
      name: params[:name].capitalize,
      price: params[:price],
      description: params[:description].capitalize,
      menu_id: current_menu_id,
    )

    redirect_to edit_menu_path(id: current_menu_id)
  end

  def update
    id = params[:id]
    menu_item = MenuItem.find_by(id: id)
    menu_item.update(price: params[:price])
    redirect_to edit_menu_path(id: current_menu_id)
  end

  def destroy
    id = params[:id]
    menu_item = MenuItem.find_by(id: id)
    menu_item.destroy
    redirect_to edit_menu_path(id: current_menu_id)
  end
end
