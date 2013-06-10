class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def availability_email(check_id, times)
    check = Check.find(check_id)
    @times = times
    @url = check.url
    mail(:to => check.email, :subject => "#{check.name} #{times.first.to_date}")
  end
end
