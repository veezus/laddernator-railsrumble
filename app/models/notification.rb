class Notification < ActionMailer::Base
  ActionMailer::Base.default_url_options[:host] ||= "laddernator.com"

  def challenged(challenger, challengee)
    from    "noreply@#{ActionMailer::Base.default_url_options[:host]}"
    subject "You have been challenged by #{challenger.login}!  You have until the end of the day to respond."
  end

end
