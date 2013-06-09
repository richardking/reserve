class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def availability_email(check_id, times)
    @times = times
    check = Check.find(check_id)
    mail(:to => check.email, :subject => "Test")
  end
end
