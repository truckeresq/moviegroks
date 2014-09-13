class UsersController < ApplicationController
  before_action :set_user, :only => [:show, :edit, :update, :delete]
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  # GET /users/new
  def new
    @user = User.new
    # @user.build_profile
  end

  # POST /users
  # POST /users.json
   def create
     @user = User.new(user_params) 
     @user.build_profile
       if @user.save
        sign_in @user
         Notifier.welcome(@user).deliver
         flash[:success] = 'Thanks for signing up!'
         redirect_to @user
       else
         render 'new'
       end
     end

# Change Password
  def reset_password
    user = User.find_by(mail: self.mail)
    unless user.nil?
      current_password BCrypt::Password.new(user.password)
      if current_password == self.user.password
      else
        nil
      end
    end
  end

  # GET /users
  # GET /users.json
  
  def index
    @users = User.paginate(page: params[:page])
  end
 
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
      @user = User.find(params[:id])
      respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { flash[:success] = "Profile updated" }
        #format.json { head :no_content }
        
        redirect_to @user
      else
        format.html { render 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
end
end


#  def user_playlist
#   @user = User.find(params[:user_id])
#   respond_to do |format|
#     format.js { render :layout => false }
#   end
# end

def user_grok
  @user = User.find(params[:user_id])
  respond_to do |format|
    format.js { render :layout => false }
  end
end

def user_favs
  @user = User.find(params[:user_id])
  #@favs = @user.favs.paginate(:page => params[:page]).per_page(10)
  respond_to do |format|
    format.js { render :layout => false }
  end
end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    redirect_to_good_slug(@user) and return if bad_slug?(@user)
end



  # DELETE /users/1
  # DELETE /users/1.json
  def delete
    @user = User.find(params[:id])
    respond_to do |format|
      format.html { redirect_to action: 'new', status: 303 }
      format.json { head :no_content }
  end
end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end


  def groks
    @groks = User.find(params[:id]).groks.order("created_at desc").page(params[:page]).per_page(20)
  end



  # GET /users/1
  # GET /users/1.json

  def show
    @user = User.find(params[:id])
    # @playlist = current_user.playlists.build
    redirect_to_good_slug(@user) and return if bad_slug?(@user)
    # @playlists = @user.playlists.paginate(page: params[:page])
    @groks = @user.groks.paginate(page: params[:page])
    # @user.favs
  end


  private
    # Use callbacks to share common setup or constraints between actions.

    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :first_name, :last_name, :email, :password, :password_confirmation, :salt, :encrypted_password, profile_attributes: [:id, :city, :state, :website])
    end

    def encrypt_password
      unless self.password.nil?
      self.encrypt_password = BCrypt::Password.create(self.password)
    end
  end

    def sign_in(user)
    cookies.permanent[:auth_token] = user.auth_token
    self.current_user = user
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

  end