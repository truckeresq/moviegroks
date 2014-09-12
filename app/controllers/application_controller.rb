class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
 
 #Delete not using Pundit
include Pundit
protect_from_forgery with: :exception
 

 # Enforces access right checks for individuals resources
 #after_action :verify_authorized, only: :destroy


rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

#Check if current slug is not the cannonical one.
def bad_slug?(object)
  params[:id] != object.to_param
end

# 301 redirect to canonical slug.
def redirect_to_good_slug(object)
  redirect_to params.merge({
                :controller => controller_name,
                :action => params[:action],
                :id => object.to_param,
                :status => :moved_permanently
              })
end



private

    def confirm_signed_in
      unless cookies[:auth_token]
        flash[:notice] = "Please sign in."
        redirect_to(:controller => 'access', :action => 'signin')
        return false #halts the before_action
      else 
        return true
      end
    end

    def user_not_authorized
      flash[:error] = 'You must be signed in to perform this action.'
    end

    
  helper_method :current_user, :signed_in?, :is_admin?
    
    def current_user
      @current_user ||= (User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]) 
      rescue ActiveRecord::RecordNotFound => e
      @current_user ||= session[:current_user_id] && User.find_by_id(session[:current_user_id]) # Use find_by_id to get nil instead of an error if user doesn't exist
      #|| User.new
    end

    def current_user=(user)
      @current_user = user
    end

    def current_user?(user)
      user == current_user
    end

    def signed_in?
      current_user != nil
    end

    def is_admin?
      signed_in? current_user.admin :false
    end

    def authorize_admin
      unless admin?
              flash[:notice] = "You cannot peek behind the veil."
               #redirect_to action: 'access/index'
               redirect_to root_path
              false #halts the before_action
    end
  end
    
     def redirect_back_or(default)
        redirect_to(session[:return_to] || default)
        session.delete(:return_to)
      end

      def store_location
        session[:return_to] = request.url if request.get?
      end
    
    def admin?
      current_user.admin?
    end
  
  def signed_in_user
      unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

end

