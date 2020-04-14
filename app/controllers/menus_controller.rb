class MenusController < ApplicationController
  def index
    @user_role = @current_user.role
    render "index"
  end

  def create
  end
end
