class NotifiersController < ApplicationController


def new
end

 # Send url to user to reset password
 def create
   user = User.find_by_email(params[:email])
   user.send_reset_password if user
   redirect_to root_url, :notice => "Email sent with password reset instructions."
 end

def edit
	@user = User.find_by_reset_password_token!(params[:id])
end

	end

  