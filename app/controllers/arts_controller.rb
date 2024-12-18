class ArtsController < ApplicationController
  before_action :get_artist
  before_action :set_art, only: %i[ show edit update destroy ]

  # GET /arts or /arts.json
  def index
    @arts = @artist.arts
  end

  # GET /arts/1 or /arts/1.json
  def show
  end

  # GET /arts/new
  def new
    @art = @artist.arts.build
  end

  # GET /arts/1/edit
  def edit
  end

  # POST /arts or /arts.json
  def create
    @art = @artist.arts.build(art_params)

    respond_to do |format|
      if @art.save
        format.html { redirect_to artist_arts_path(@artist), notice: "Art was successfully created." }
        format.json { render :show, status: :created, location: @art }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @art.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /arts/1 or /arts/1.json
  def update
    respond_to do |format|
      if @art.update(art_params)
        format.html { redirect_to artist_art_path(@artist), notice: "Art was successfully updated." }
        format.json { render :show, status: :ok, location: @art }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @art.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /arts/1 or /arts/1.json
  def destroy
    @art.destroy!

    respond_to do |format|
      format.html { redirect_to artist_arts_path(@artist), status: :see_other, notice: "Art was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    @arts = Art.all
  
    if params[:description].present?
      @arts = @arts.where("description LIKE ?", "%#{params[:description]}%")
    end
  
    if params[:category].present?
      @arts = @arts.where("category LIKE ?", "%#{params[:category]}%")
    end
  
    if params[:tags].present?
      @arts = @arts.where("tags LIKE ?", "%#{params[:tags]}%")
    end
  
    if params[:artist_name].present?
      @arts = @arts.joins(:artist).where("artists.username LIKE ?", "%#{params[:artist_name]}%")
    end
  
    render 'artists/index'
  end

  def download_image
    @art = Art.find(params[:id])
    @art.increment!(:download_count)
    redirect_to rails_blob_path(@art.art_image, disposition: 'attachment')
  end

  def download_image_with_resolution
    @art = Art.find(params[:id])
    width = params[:width].to_i
    height = params[:height].to_i

    if @art.art_image.attached?
      # Process the variant
      variant = @art.resized_variant(width, height)
      @art.increment!(:download_count)
      redirect_to rails_representation_url(variant, disposition: 'attachment')
    else
      redirect_to root_path, alert: 'Image not found'
    end
  end

  private
    # creates a local @artist instance variable by finding a artist instance by artist_id
    def get_artist
      if params[:artist_id].present?
        @artist = Artist.find(params[:artist_id])
      else
        @artist = nil
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_art
      @art = @artist.arts.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def art_params
      params.require(:art).permit(:title, :description, :tags, :category, :license_type, :download_count, :artist_id, :art_image)
    end
end
