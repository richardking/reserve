class ApiKey < ActiveRecord::Base
  attr_accessible :access_token
  before_create :generate_token

  private

  def generate_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end

end
