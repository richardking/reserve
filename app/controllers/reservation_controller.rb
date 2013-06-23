class ReservationController < ApplicationController
  def index
    @checks = Check.all
    @check = Check.new
  end
end
