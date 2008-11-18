class Notification < ActionMailer::Base
  ActionMailer::Base.default_url_options[:host] ||= "hashrocket.laddernator.com"

  def challenged(challenger, challengee, challenge)
    set_up_email
    recipients challengee.email
    subject    "You have been challenged by #{challenger.login}!  You have until the end of the day to respond."
    body :challenger => challenger, :challengee => challengee, :challenge => challenge
  end
  
  def accepted_challenge(challenger, challengee, challenge)
    set_up_email
    recipients challenger.email
    subject "Your challenge was accepted!"
    body :challenger => challenger, :challengee => challengee, :challenge => challenge
  end
  
  def rejected_challenge(challenger, challengee)
    set_up_email
    recipients challenger.email
    subject "Your challenge was rejected!"
    body :challenger => challenger, :challengee => challengee
  end
  
  def set_up_email
    from "noreply@#{ActionMailer::Base.default_url_options[:host]}"
  end

end
