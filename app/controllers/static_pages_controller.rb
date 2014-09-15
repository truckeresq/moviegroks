class StaticPagesController < ApplicationController
 
  def home
    @groks = Grok.where(created_at: (Time.now - 120.day)..Time.now).limit(4)
  end

  def about
  end

  def help
  end

  def terms
  end

  def privacy
  end
  
end
