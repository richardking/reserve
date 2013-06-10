class CheckTime
  @queue = :availability

  def self.perform
    Check.find(:all, :conditions => "Date(start_time) >= Date(NOW())").each do |check|
      times = Check.find(check.id).check_time
      if times.present?
        UserMailer.availability_email(check.id, times).deliver!
      end
    end
  end
end
