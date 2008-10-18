ActionController::Routing::Routes.draw do |map|
  map.resources :players
  map.resource :session

  map.resources :ladders
end
