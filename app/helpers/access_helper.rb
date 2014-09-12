module AccessHelper
def attempt_signin
    user = User.where(:email => params[:email]).first
        if user && user.authenticate(params[:password])
          if params[:remember_me]
          cookies.permanent[:auth_token] = user.auth_token
          else 
          cookies[:auth_token] = user.auth_token
        end

        flash[:notice] = "You are now signed in."
        redirect_to root_path 
  
          else
        flash[:error] = "Invalid email/password combination."
        redirect_to(:action => "signin")
      end
    end

    def current_user
      #@current_user ||= ((User.find(session[:user_id]) if session[:user_id]) || User.new)
      @current_user ||= (User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]) 
      #|| User.new
    end

    def signout
    cookies.delete(:auth_token) 
    flash[:notice] = "Signed out"
    redirect_to(:action => "signin")
  end

  def signed_in_user
    unless signed_in?
    store_location
    redirect_to signin_url, notice: "Please sign in."
    end
  end

end
