module GroksHelper

	def top_100
			@groks = Grok.tally(
			{ :at_least => 1, 
			:at_most => 500,     
  			:limit => 100,
  			:order => 'vote_count desc'
			})
	end

  def s3_upload_policy options = {}
    options[:content_type] ||= 'audio/wav'
    options[:acl] ||= 'public-read'
    options[:max_file_size] ||= 6.megabyte
    options[:path] ||= ''

    Base64.encode64(
      "{'expiration': '#{1.hour.from_now.utc.strftime('%Y-%m-%dT%H:%M:%S.000Z')}',
        'conditions': [
          {'bucket': '#{ENV['bucket']}'},
          ['eq', '$key', key],
          {'acl': '#{options[:acl]}'},
          ['content-length-range', 0, #{options[:max_file_size]}],
          ['eq', '$Content-Type', '#{options[:content_type]}'],
          {'success_action_status': '201'},
        ]
    }").gsub(/\n|\r/, '')
  end


  def s3_upload_signature options = {}
    Base64.encode64(
      OpenSSL::HMAC.digest(
      OpenSSL::Digest::Digest.new('sha1'),
      ENV['secret_access_key'], s3_upload_policy(options))).gsub("\n","")
  end
end