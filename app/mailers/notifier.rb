class Notifier < ActionMailer::Base
  default from: "hello@moviegroks.com"
  	#return_path: 'system@moviegroks.com'


  def welcome(user)
  	@user = user
  	mail(:to => user.email, :subject => "Thanks for signing up!")
  end

  def reset_password(user)
      @user = user
      mail :to => user.email, :subject => "Password Reset"
  end
end
