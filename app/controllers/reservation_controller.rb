class ReservationController < ApplicationController
  def index
    @checks = Check.all
    @check = Check.new
    @resque_canary = if Resque.redis.get("hourly_check")
                       Time.parse(Resque.redis.get("hourly_check")) > 2.hours.ago
                     else
                       false
                     end
  end
end
