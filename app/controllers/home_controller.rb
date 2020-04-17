class HomeController < ApplicationController
  skip_before_action :ensure_user_logged_in
  skip_before_action :ensure_admin_logged_in
  skip_before_action :ensure_order_created

  def index
    if current_user
      if current_user.role == "owner"
        redirect_to admin_index_path
      else
        redirect_to orders_path
      end
    else
      render "index"
    end
  end
end
