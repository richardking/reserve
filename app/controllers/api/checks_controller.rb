class Api::ChecksController < ApplicationController
  # http_basic_authenticate_with :name => "rking", :password => "password"
  respond_to :json
  before_filter :restrict_access

  def create
    puts params.inspect
    puts "x"
    # :email, :enabled, :end_time, :start_time, :url, :name
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
