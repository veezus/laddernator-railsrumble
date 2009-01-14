ActionController::Routing::Routes.draw do |map|
  map.resources :players
  map.resource :session

  map.resources :ladders, :has_many => [:ranks] do |ladder|
    #TODO: Find a better way of handling these gets that should be puts (they are links in emails)
    ladder.resources :challenges, :member => {:won => :put, :lost => :put, :accept => :get, :reject => :get}
  end
  map.resources :ranks, :member => {:higher => :put, :lower => :put}

  map.login 'login', :controller => 'sessions', :action => 'new'
  map.signup 'signup', :controller => 'players', :action => 'new'
  
  map.root :controller => 'ladders', :action => 'index', :resource_path => '/ladders'
end
