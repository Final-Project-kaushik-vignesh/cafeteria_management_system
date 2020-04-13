class SessionsController < ApplicationController
    def new
    
    end

    def create
        user = User.find_by(email: params[:email])
        if user && user.authenticate(params[:password])
            session[:current_user_id] = user.id
            redirect_to "/"
        else
            flash[:error] = "Your login attempt is Invaled. Please retry"
            redirect_to new_sessions_path, warning: "Invalid User Id or Password"
            
        end
    end

    def destroy
        session[:current_user_id]=nil
        @current_user = nil
        redirect_to "/"
    end

end
