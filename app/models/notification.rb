class Notification < ActionMailer::Base
  ActionMailer::Base.default_url_options[:host] ||= "yourway.org"

  def challenged(challenger, challengee)
    from    "noreply@#{ActionMailer::Base.default_url_options[:host]}"
    subject "You have been challenged!"
  end

end
