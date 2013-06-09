class ReservationController < ApplicationController
  def index
    @checks = Check.all
  end
end
