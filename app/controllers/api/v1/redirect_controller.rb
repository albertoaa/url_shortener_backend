class Api::V1::RedirectController < ApplicationController
  before_action :set_redirect, only: [:show, :update, :destroy]

  # GET /redirects
  def index
    @redirects = Redirect.all

    render json: @redirects
  end

  # GET /redirects/1
  def show
    render json: @redirect
  end

  # POST /redirects
  def create
    @redirect = Redirect.new(redirect_params)

    if @redirect.save
      render json: @redirect, status: :created, location: @redirect
    else
      render json: @redirect.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /redirects/1
  def update
    if @redirect.update(redirect_params)
      render json: @redirect
    else
      render json: @redirect.errors, status: :unprocessable_entity
    end
  end

  # DELETE /redirects/1
  def destroy
    @redirect.destroy
  end

  def redirect
    @link = Link.where(shortened: params[:shortened]).first

    if @link
      user_location = "#{request.location.country}, #{request.location.city}, #{request.location.address}"
      redirect = Redirect.new( location: user_location, time: Time.now )
      @link.redirects << redirect
      redirect_to @link.url
    else
      render json: { error: 'bad link'}, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_redirect
      @redirect = Redirect.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def redirect_params
      params.permit(:location, :time)
    end
end
