class UrlsController < ApplicationController
  before_action :set_url, only: [:show, :update, :destroy]
  
   def index
    @urls = current_user.urls
    json_response(@urls)
   end

  def show
    json_response(@url)
  end

  def create
    @url = current_user.urls.create!(url_params)
    json_response(@url, :created)
  end

  private

  def url_params
    params.permit(:original_url)
  end

  def set_url
    @url = Url.find_by_short_url(params[:id])
  end

end
