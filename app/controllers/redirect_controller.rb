class RedirectController < ApplicationController
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
end
