class MenusController < ApplicationController
  def index
    @user_role = @current_user.role
    render "index"
  end

  def create
    menu = Menu.create!(
      name: params[:name].capitalize,
    )

    redirect_to new_menu_path
  end

  def destroy
    id = params[:id]
    menu = Menu.find(id)
    menu.destroy
    redirect_to new_menu_path
  end

  def edit
    session[:current_menu_id] = params[:id]
    render "edit"
  end
end
