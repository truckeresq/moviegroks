require 'asin/configuration'

ASIN::Configuration.configure do |config|
	config.secret = ENV['secret_access_key']
	config.key = ENV['access_key_id']
	config.associate_tag = 'book05e9-20'
end

require 'httpi'
HTTPI.adapter = :curb
HTTPI.logger = Rails.logger