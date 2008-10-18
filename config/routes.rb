ActionController::Routing::Routes.draw do |map|
  map.resources :players
  map.resource :session

  map.resources :ladders

  map.login 'login', :controller => 'sessions', :action => 'new'
  map.signup 'signup', :controller => 'players', :action => 'new'
end
