class CheckTime
  @queue = :availability

  def self.perform
    Check.all.each do |check|
      record = Check.find(check.id)
      if times = record.check_time
        UserMailer.availability_email(check_id, times)
      end
    end
  end
end
