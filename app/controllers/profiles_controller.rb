class ProfilesController < ApplicationController
  before_action :set_profile, :only => [:show, :edit, :update, :destroy]
  before_action :confirm_signed_in, :except => [:index, :show]
  
  # Enforces access right checks for individuals resources
  after_action :verify_authorized, :except => [:index, :show]
  

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    # user = User.find(params[:id])
    # @profile = user.profile
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(params[:id])
    # @profile = current_user.profile
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
     @profile = Profile.find(params[:id])
     @profile.update_attributes(params[profile_params])
end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    Profile.find(params[:id]).destroy
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.


    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:id, :city, :state, :website, :user_id)
    end
end
