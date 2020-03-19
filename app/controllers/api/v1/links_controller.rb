class Api::V1::LinksController < ApplicationController
  # GET /links
  def index
    @links = Link.all

    render json: @links
  end

  def store
    @link = Link.create!(link_params)

    if @link.valid?
      @link.shortened = "#{request.base_url}/#{@link.shortened}"
      render json: @link, status: :created
    end
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
    # Only allow a trusted parameter "white list" through.
    def link_params
      params.permit(:url, :shortened)
    end
end
