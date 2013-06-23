class ChecksController < ApplicationController
  def create
    @check = Check.create(params[:check])
    redirect_to :root
  end
end
