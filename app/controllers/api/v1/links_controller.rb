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
      @link.shortened = "#{request.base_url}/#{@link.shortened}"
      render json: @link, status: :created, location: api_v1_links_get_url(@link)
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

  # GET LINK BY URL
  def get
    @link = Link.where(url: link_params[:url]).first

    if @link
      render json: {shortened:  "#{request.base_url}/#{@link.shortened}" }
    else
      render json: nil, head: :no_content, status: 204
    end
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
