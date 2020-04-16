class MenuItemsController < ApplicationController
  skip_before_action :ensure_admin_logged_in

  def index
    active_menu = Menu.find_by(Active_Menu: true)
    @menu_item = MenuItem.of_menu(active_menu)
  end

  def create
    menu_item = MenuItem.create!(
      name: params[:name],
      price: params[:price],
      description: params[:description],
      menu_id: current_menu_id,
    )

<<<<<<< HEAD
    redirect_to edit_menu_path(id: current_menu_id)
=======
    redirect_to "/menus/#{current_menu_id}/edit"
>>>>>>> 32d31d81b78a78ff7df3306adc5704d50d624078
  end
end
