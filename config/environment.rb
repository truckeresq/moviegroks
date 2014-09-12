# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Load the app's custom environment variables here, so that they are loaded before environments/*.rb
s3_credentials = File.join(Rails.root, 'config', 's3_credentials.rb')
load(s3_credentials) if File.exists?(s3_credentials)

# Initialize the Rails application.
MovieGroks::Application.initialize!

  
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['SENDGRID_USERNAME'],
  :password       => ENV['SENDGRID_PASSWORD'],
  :domain         => 'heroku.com',
  :enable_starttls_auto => true,
  # :ssl            => true
}