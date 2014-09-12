class ThemesController < ApplicationController
  before_action :set_theme, :only => [:edit, :update, :destroy]
  before_action :confirm_signed_in, :only => [:new, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:new, :destroy]
  
  # GET /themes
  # GET /themes.json
def index
    @themes = Theme.paginate(page: params[:page])
end

  # GET /themes/1
  # GET /themes/1.json
  # GET /themes/:id/groks
def show
    @theme = Theme.find(params[:id])
    @groks = @theme.groks.paginate(page: params[:page]) 
    redirect_to_good_slug(@theme) and return if bad_slug?(@theme)
    
end

  # GET /themes/new
def new
    @theme = Theme.new
    # @themes = Theme.sorted 
    render action: 'new'
end 

# GET /themes/1/edit
def edit
      @theme = Theme.find(params[:id])
 end

  # POST /themes
  # POST /themes.json
def create
  @theme = Theme.new(theme_params)
  if @theme.save
    Theme.dedupe
    redirect_to @theme
  else
    render action: 'new', notice: "You aren't authorized to perform this action."
  end
end

  # PATCH/PUT /themes/1
  # PATCH/PUT /themes/1.json
def update
    @theme = Theme.find(params[:id])
      if @theme.update(theme_params)
        redirect_to @theme, notice: 'Theme was successfully updated.'
      else
        render 'edit', notice: "You aren't authorized to perform this action."
    end
end  

  # DELETE /themes/1
  # DELETE /themes/1.json
def delete
  @theme = Theme.find(params[:id])
    respond_to do |format|
      format.html { redirect_to action: 'new', status: 303 }
      format.json { head :no_content }
    end
end

  # DESTROY /themes/1
  # DESTROY /themes/1.json

def destroy
    Theme.find(params[:id]).destroy
    flash[:success] = "Theme deleted."
    redirect_to themes_url
 end

  private
    # Use callbacks to share common setup or constraints between actions.
    
    # Need to add method so that User can add a theme but it must be 
    # approved before it goes live.
    
    def set_theme
      @theme = Theme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def theme_params
      params.require(:theme).permit(:keyword)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

   def correct_user
      @theme = current_user.themes.find_by(id: params[:id])
      redirect_to root_url if @theme.nil?
  end
end
