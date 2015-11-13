Rails.application.routes.draw do
  use_doorkeeper

  namespace :v1 do
    jsonapi_resources :users, except: [:destroy]
    jsonapi_resources :organizations
    jsonapi_resources :memberships
    jsonapi_resources :bid_types
    jsonapi_resources :donation_categories
    jsonapi_resources :auctions
    jsonapi_resources :donations
    jsonapi_resources :donors
    jsonapi_resources :donation_donors
    jsonapi_resources :tickets
    jsonapi_resources :bidders
    jsonapi_resources :bid_groups
    jsonapi_resources :auction_items
    jsonapi_resources :bids
  end
end
