class Api::V1::LinksController < ApplicationController
  before_action :set_link, only: [:show, :update, :destroy]

  # GET /links
  def index
    @links = Link.all

    render json: @links
  end

  # GET /links/1
  def show
    render json: @link
  end

  # POST /links
  def create
    @link = Link.new(link_params)

    if @link.save
      render json: @link, status: :created, location: api_v1_link_url(@link)
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /links/1
  def update
    if @link.update(link_params)
      render json: @link
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

  # DELETE /links/1
  def destroy
    @link.destroy
  end

  # GET TOTAL OF LINKS /count
  def count
    @count = Link.count
    render json: @count
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def link_params
      params.permit(:url, :shortened)
    end
end
