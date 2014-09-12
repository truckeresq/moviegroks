class FavoriteQuotesController < ApplicationController
  before_action :set_favorite_quote, :only => [:edit, :update, :destroy]
  before_action :confirm_signed_in, :only => [:new, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:new, :destroy]

  # GET /favorite_quotes
  # GET /favorite_quotes.json
  def index
    @favorite_quotes = FavoriteQuotes.all
  end

  # GET /favorite_quotes/1
  # GET /favorite_quotes/1.json
  def show
    @favorite_quotes = FavoriteQuotes.find params[:id]
  end

  # GET /favorite_quotes/new
  def new
    @favorite_quotes = FavoriteQuotes.new
  end

  # GET /favorite_quotes/1/edit
  def edit
  end

  # POST /favorite_quotes
  # POST /favorite_quotes.json
  def create
    @favorite_quotes = FavoriteQuotes.new(favorite_quote_params)

    respond_to do |format|
      if @favorite_quotes.save
        format.html { redirect_to @favorite_quote, notice: 'Favorite quote was successfully created.' }
        format.json { render action: 'show', status: :created, location: @favorite_quote }
      else
        format.html { render action: 'new' }
        format.json { render json: @favorite_quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /favorite_quotes/1
  # PATCH/PUT /favorite_quotes/1.json
  def update
    respond_to do |format|
      if @favorite_quotes.update(favorite_quote_params)
        format.html { redirect_to @favorite_quote, notice: 'Favorite quote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @favorite_quote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /favorite_quotes/1
  # DELETE /favorite_quotes/1.json
  def destroy
    @favorite_quotes.destroy
    respond_to do |format|
      format.html { redirect_to favorite_quotes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_favorite_quote
      @favorite_quote = FavoriteQuotes.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def favorite_quote_params
      params.require(:favorite_quote).permit(:quote, :movie, :year)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

   def correct_user
      @favorite_quote = current_user.favorite_quotes.find_by(id: params[:id])
      redirect_to root_url if @favorite_quotes.nil?
  end

end