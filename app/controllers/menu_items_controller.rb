class MenuItemsController < ApplicationController
  skip_before_action :ensure_admin_logged_in

  def index
    @menu_items = MenuItem.of_menu()
  end
end
