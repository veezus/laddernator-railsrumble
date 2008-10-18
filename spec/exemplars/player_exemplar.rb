class Player
  generator_for :login, :start => 'login' do |prev|
    prev.succ
  end
  generator_for :email, :start => 'login@example.com' do |prev|
    user, domain = prev.split('@')
    user.succ + '@' + domain
  end
  generator_for :password, 'password'
  generator_for :password_confirmation, 'password'
end