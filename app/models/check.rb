require 'open-uri'

class Check < ActiveRecord::Base
  attr_accessible :email, :enabled, :end_time, :start_time, :url

  def check_time
    parsed = Nokogiri::HTML(open(url))
    times = parsed.css('ul.ResultTimes li').map { |v| Time.strptime(v.to_s.match(/(\d*\/.*[A|P]M)\'\,/)[1], "%m/%d/%Y %I:%M:%S %p") rescue nil}
    times.compact!.select! {|t| t >= start_time.in_time_zone("Pacific Time (US & Canada)") && t <= end_time.in_time_zone("Pacific Time (US & Canada)") }
    times
  end
end
