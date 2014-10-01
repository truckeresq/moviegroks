class MoviesController < ApplicationController
  before_action :confirm_signed_in, :only => [:create]
  before_action :admin_user, only: :destroy
  respond_to :json

def index
  if params[:tag]
    @movies = Movie.tagged_with(params[:tag]).paginate(page: params[:page])
  else
      @movies = Movie.paginate(page: params[:page])
  end
    respond_to do |format|
      format.html
      format.json { render json: @movies, only: [:id, :year, :title, :movie_image_url, :movie_trailer_url] }
    end
   end

def new
   @movie = Movie.new
end

# def search
#   @items = Movie.new.search_keywords(params[:search])
#   render :partial => 'search_results.json'
# end


  def create
      @movie = Movie.new(movie_params)
      respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie saved.' }
        format.json { render action: 'index', status: :created, location: @movie }
      else
        format.html { render action: 'new' }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @movie = Movie.find(params[:id])
    @groks = @movie.groks.paginate(page: params[:page]) 
    end


# GET /movies/1/edit
  def edit
     @movie = Movie.find(params[:id])
  end

 # PATCH/PUT /themes/1
  # PATCH/PUT /themes/1.json
def update
    @movie = Movie.find(params[:id])
      if @movie.update(movie_params)
        redirect_to @movie, notice: 'Movie was successfully updated.'
      else
        render 'edit', notice: "You aren't authorized to perform this action."
    end
end

  # DESTROY /themes/1
  # DESTROY /themes/1.json

  def destroy
    movie = Movie.find(params[:id]).destroy
      respond_to do |format|
      format.html { redirect_to action: 'index'}
      format.json { head :no_content }
  end
  end

private
    # Use callbacks to share common setup or constraints between actions.
    
def set_movie
      @movie = Movie.find(params[:id])
end

    # Never trust parameters from the scary internet, only allow the white list through.
def movie_params
     params.require(:movie).permit(:title, :summary, :movie_image_url, :movie_trailer_url, :year, :tag_list)
end

def admin_user
    redirect_to(root_url) unless current_user.admin?
end

end