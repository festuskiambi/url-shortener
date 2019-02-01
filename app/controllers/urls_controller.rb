class UrlsController < ApplicationController
  before_action :set_url, only: [:show, :update, :destroy]
  def create
    @url = Url.create(url_params)
    json_response(@url, :created)
  end

  private
  
  def url_params
    params.permit(:original_url)
  end

  def set_url
    @url = Url.find(params[:id])
  end

end
