class MenuItemsController < ApplicationController
  skip_before_action :ensure_admin_logged_in

  def index
    @menu_items = MenuItem.of_menu()
  end

  def create
    menu_item = MenuItem.create!(
      name: params[:name],
      price: params[:price],
      description: params[:description],
      menu_id: current_menu_id,
    )

    redirect_to "/menus/#{current_menu_id}/edit"
  end
end
