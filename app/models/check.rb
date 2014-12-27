require 'open-uri'

class Check < ActiveRecord::Base
  attr_accessible :name, :email, :start_time, :end_time, :url, :enabled

  validates :name, :email, :start_time, :end_time, :url, :presence => true

  def check_time
    times = if Time.zone.now.utc_offset == -25200
              find_time(parsed).map { |t| t - 1.hour }
            else
              find_time(parsed)
            end
    if times.present?
      times.select {|t| t >= start_time.in_time_zone("Pacific Time (US & Canada)") && t <= end_time.in_time_zone("Pacific Time (US & Canada)") }
    else
      []
    end
  end

  def enable
    update_attribute(:enabled, true)
  end

  def disable
    update_attribute(:enabled, false)
  end

  private

  def parsed
    @parsed ||= Nokogiri::HTML(open(url))
  end

  def find_time(parsed)
    # parsed.css('ul.ResultTimes li').map { |v| Time.zone.strptime(v.to_s.match(/(\d*\/.*[A|P]M)\'\,/)[1], "%m/%d/%Y %I:%M:%S %p") rescue nil}.compact
    # parsed.css('ul.dtp-results-times li').map { |v| Time.zone.strptime(v.to_s.match(/(\d{1,2}:\d*.[A|P]M)/)[1], "%I:%M %p") rescue nil}.compact
    parsed.css('ul.dtp-results-times li').map { |v| Time.zone.strptime(v.to_s.match(/data-datetime="(20.* \d{1,2}:\d{1,2})"/)[1],"%Y-%m-%d %H:%M") rescue nil}.compact
  end
end
