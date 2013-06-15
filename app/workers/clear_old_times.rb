class ClearOldTimes
  @queue = :availability

  def self.perform
    Check.find(:all, :conditions => "Date(end_time) >= Date(NOW()) AND enabled = true").each do |check|
      check.destroy
    end
  end
end
