class MenusController < ApplicationController
  skip_before_action :ensure_order_created

  def index
    @user_role = @current_user.role
    render "index"
  end

  def create
    menu = Menu.new(
      name: params[:name].capitalize,
      active_menu: false,
    )
    if menu.valid?
      menu.save!
      redirect_to menus_path
    else
      redirect_to menus_path
      flash[:errors] = menu.errors
    end
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
    Menu.all.each { |menu| menu.update(active_menu: false) }
    id = params[:id]
    menu = Menu.find_by(id: id)
    menu.update(active_menu: true)
    redirect_to menus_path
  end

  def new_item
    menu_item = MenuItem.new(
      name: params[:name].capitalize,
      price: params[:price],
      description: params[:description].capitalize,
      menu_id: current_menu_id,
    )
    if menu_item.valid?
      menu_item.save!
      redirect_to edit_menu_path(id: current_menu_id)
    else
      redirect_to edit_menu_path(id: current_menu_id)
      flash[:errors] = menu_item.errors
    end
  end

  def delete_item
    id = params[:id]
    menu_item = MenuItem.find(id)
    menu_item.destroy
    redirect_to edit_menu_path(id: current_menu_id)
  end

  def update_item
    id = params[:id]
    menu_item = MenuItem.find_by(id: id)
    menu_item.update(price: params[:price])
    redirect_to edit_menu_path(id: current_menu_id)
    flash[:notice] = "Price of the Item has been updated !!"
  end
end
