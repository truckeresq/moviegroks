class AccessController < ApplicationController
  before_action :confirm_signed_in, :except => [:signin, :attempt_signin, :signout]
  before_action :authorize_admin, :only => :index

  def index 
  @admin = User.where(:is_admin => true)   
  end

  def signin
  # login form
  end

  def signup
  end

  def attempt_signin
    user = User.where(:email => params[:email]).first
        if user && user.authenticate(params[:password])
          redirect_back_or user
          if params[:remember_me]
          cookies.permanent[:auth_token] = user.auth_token
          else 
          cookies[:auth_token] = user.auth_token
        end
          else
        flash[:error] = "Invalid email/password combination."
        redirect_to(:action => "signin")
      end
    end

  def signout
    cookies.delete(:auth_token) 
    flash[:notice] = "Signed out"
    redirect_to(:action => "signin")
  end
   

end
