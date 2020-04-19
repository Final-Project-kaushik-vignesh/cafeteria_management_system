class MenuItemsController < ApplicationController
  skip_before_action :ensure_admin_logged_in

  def index
    active_menu = Menu.find_by(active_menu: true)
    @menu_item = MenuItem.of_menu(active_menu)
  end
end
