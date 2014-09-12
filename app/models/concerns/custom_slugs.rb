require 'active_support/concern'

module CustomSlugs
  extend ActiveSupport::Concern


  module ClassMethods

    # Override 'to_param'.
   
    def custom_slugs_with(seed)
      self.redefine_method(:to_param) do
        [id, self.send(seed).parameterize].join("-")
      end
    end
  end

	# Include method in models.
	ActiveRecord::Base.send(:include, CustomSlugs)
	end