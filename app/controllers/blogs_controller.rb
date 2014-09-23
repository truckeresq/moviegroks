class BlogsController < ApplicationController
  before_action :set_blog, :only => [:edit, :update, :destroy]
  before_action :confirm_signed_in, :only => [:new, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:new, :destroy]

  # GET /blogs
  # GET /blogs.json
  def index
    @blogs = Blog.paginate(page: params[:page])
  end

  # GET /blog/1
  # GET /blog/1.json
  def show
    @blog = Blog.find params[:id]
    @movie = Movie.find_by(params[:movie_id])
    @grok = Grok.find_by(params[:movie_id]) 
  end

  # GET /blog/new
  def new
    @blog = Blog.new
    @movies = Movie.all
    respond_to do |format|
      format.html #new.html.erb
      format.json { render json: @blog.errors}
    end
  end

  # GET /blog/1/edit
  def edit
  end

  # POST /blog
  # POST /blog.json
  def create
    @blog = Blog.new(blog_params) 
    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'Blog was successfully created.' }
        format.json { render action: 'show', status: :created, location: @blog }
      else
        format.html { render action: 'new' }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blog/1
  # PATCH/PUT /blog/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: 'Blog was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blog/1
  # DELETE /blog/1.json
  def destroy
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:post, :movie_ids => [])
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

   def correct_user
      @blog = current_user.blog.find_by(id: params[:id])
      redirect_to root_url if @blog.nil?
  end

end