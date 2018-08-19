class AdsController < ApplicationController
  before_action :authorize_access_request!, only: [:create, :update, :destroy]
  before_action :set_ad, only: [:show, :update, :destroy]

  # GET /ads
  def index
    @ads = Ad.all
    render json: @ads, only: [:title, :description, :user_id], methods: [:image_url]
  end

  # GET /ads/1
  def show
    render json: @ad
  end

  # POST /ads
  def create
    @ad = current_user.ads.build(ad_params)
    image = Paperclip.io_adapters.for(params[:ads][:image])
    image.original_filename = params[:ads][:imageName]
    @ad.image = image

    if @ad.save
      render json: @ad, status: :created, location: @ad
    else
      render json: @ad.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ads/1
  def update
    if @ad.update(ad_params)
      render json: @ad
    else
      render json: @ad.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ads/1
  def destroy
    @ad.destroy
  end

  def image
    @ad.image.url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad
      @ad = Ad.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ad_params
      params.require(:ads).permit(:title, :description, :promo, :image, :user_id)
    end
end
