class ChecksController < ApplicationController
  def create
    @check = Check.create(params[:check])
    redirect_to :root
  end

  def destroy
    Check.find(params[:id]).destroy
    redirect_to :root, notice: "Succesfully deleted"
  end

end
