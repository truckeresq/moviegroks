class StaticPagesController < ApplicationController
 
  def home
    @groks = Grok.most_voted.sort_by { |grok| grok.votes.size }.reverse
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
