class Api::ChecksController < ApplicationController
  respond_to :json
  before_filter :restrict_access

  def index
    render :json => { :success_index => true }
  end

  def create
    check = Check.create(params[:check])

    if check.id
      render :json => { :success => true }
    else
      render :json => { :success => false, :error => "Invalid parameters" }
    end
  end

  private

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      ApiKey.exists?(access_token: token)
    end
  end
end
