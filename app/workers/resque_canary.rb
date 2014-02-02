class ResqueCanary
  def self.perform
    Resque.redis.set("hourly_check", Time.now)
  end
end
