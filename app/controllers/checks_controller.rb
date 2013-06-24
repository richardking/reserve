class ChecksController < ApplicationController
  def create
    @check = Check.create(params[:check])
    redirect_to :root
  end

  def destroy
    Check.find(params[:id]).destroy
    redirect_to :root, info: "Succesfully deleted"
  end

end
