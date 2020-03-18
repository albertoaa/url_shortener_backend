class RedirectsController < ApplicationController
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_redirect
      @redirect = Redirect.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def redirect_params
      params.require(:redirect).permit(:location, :time)
    end
end
