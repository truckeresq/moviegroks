module ApplicationHelper
	# Returns the full title on a per-page basis.
	def full_title(page_title)
		base_title = "Moviegroks"
		if page_title.empty?
			base_title
		else
			'#{base_title} | #{page_title}'
		end
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
    
    def present(object, klass = nil)
      klass ||= "#{object.class}Presenter" .constantize
      presenter = klass.new(object, self)
      yield presenter if block_given?
      presenter
     end

    def image_for(book)
      if book.small_image_url.nil? || book.small_image_url.blank?
        image_tag('no_image.jpg')
      else
        image_tag(book.small_image_url)
    end
  end
  
  def time_ago time, append = ' ago'
  return time_ago_in_words(time).gsub(/about|less than|almost|over/, '').strip << append
end

end
