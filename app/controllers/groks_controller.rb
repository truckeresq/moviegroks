class GroksController < ApplicationController
   respond_to :json

  before_action :set_grok, :only => [:edit, :update, :delete]
  before_action :signed_in_user, only: [:new]
  before_action :correct_user, only: :destroy
  #after_action :audio_cleanup, only: :update

  # GET /groks
  # GET /groks.json
  def index
    @groks = Grok.paginate(page: params[:page])
end


  # GET /groks/1
  # GET /groks/1.json
  def show
    @grok = Grok.find params[:id]
    redirect_to_good_slug(@grok) and return if bad_slug?(@grok) 
    @favorite_quotes = FavoriteQuotes.offset(rand(FavoriteQuotes.count)).first
    respond_to do |format|
      format.html
      format.js { render :js => "window.location.href = ' "+grok_path(@grok)+" ' "}
  end
end

def audio_cleanup
  @grok = Grok.find params[:id]
  @grok.delete_temp_audio
end

  # GET /groks/new
  def new
    @grok = Grok.new
    @grok.build_theme
    @grok.build_movie
    respond_to do |format|
      format.html #new.html.erb
      format.json { render json: @grok.errors}
    end
  end


  # GET /groks/1/edit
  def edit
    @grok = Grok.find params[:id]
    redirect_to_good_slug(@grok) and return if bad_slug?(@grok)
  end

 
  # POST /groks
  # POST /groks.json
  def create
    @grok = Grok.new(grok_params)
    @grok = current_user.groks.build(grok_params)
   respond_to do |format|
    if @grok.save     
    format.js { render :js => "window.location.href = ' "+grok_path(@grok)+" ' "}
    else
    format.js {}
    end
  end
end



def uploadFile
  audio = params[:audio].tempfile
  key = 'uploads/'+params[:audio].original_filename
  s3 = AWS::S3.new(
        :access_key_id => ENV['access_key_id'],
        :secret_access_key => ENV['secret_access_key'],
        )
  obj = s3.buckets['moviegroksTest'].objects.create(key, audio, :acl=> :public_read)
  audio_remote_url = obj.public_url().to_s  
  render text: audio_remote_url
end


def get_image
end

def processing_audio
@favorite_quotes = FavoriteQuotes.offset(rand(FavoriteQuotes.count)).first
end

  # PATCH/PUT /groks/1
  # PATCH/PUT /groks/1.json
  def update
    @grok = Grok.find(params[:id])
    if @grok.update(grok_params)
        redirect_to @grok, notice: 'Grok was successfully updated.' 
    else
      render action: 'edit'
  end
end

  # DELETE /groks/1
  # DELETE /groks/1.json
  def delete
    @grok = Grok.find(params[:id])
    # @grok.audio = nil
    # @grok.save
    respond_to do |format|
      format.html { redirect_to action: 'new', status: 303 }
      format.json { head :no_content }
    end
  end

  # DELETE /groks/1
  # DELETE /groks/1.json
  def destroy
    @user = @current_user
    @grok.destroy
    redirect_to @user
  end

  def vote_for
    begin
    grok = Grok.find(params[:id])
    unless current_user.voted_for?(grok)
    current_user.vote_for(grok)
    respond_to do |format|
      format.js { render :layout => false, locals: { grok: grok} }
    end
  end
end
end
  

  def unvote_for
    begin
    grok = Grok.find(params[:id])
    current_user.unvote_for(grok)
    respond_to do |format|
      format.js { render :layout => false, locals: { grok: grok } }
    end
  end
end


  def votes_total
    votes_total = grok.votes_for
  end

  private
    
   # Use callbacks to share common setup or constraints between actions.
  def set_grok
      @grok = Grok.find(params[:id])
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  
  def grok_params
      params.require(:grok).permit(:user_id, :pitch, :authorship, :title, :audio, :audio_remote_url, :processing, :audio_content_type, :audio_file_name, :audio_file_size, theme_attributes: [:id, :keyword], movie_attributes: [:id, :title, :movie_image_url, :movie_trailer_url])
  end

  def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end

  def correct_user
      @grok = current_user.groks.find_by(id: params[:id])
      redirect_to root_url if @grok.nil?
  end

end