Rails.application.routes.draw do
  use_doorkeeper

  namespace :v1 do
    jsonapi_resources :users, except: [:destroy]
    jsonapi_resources :organizations
    jsonapi_resources :memberships
    jsonapi_resources :bid_types
    jsonapi_resources :donation_categories
    jsonapi_resources :auctions
  end
end
