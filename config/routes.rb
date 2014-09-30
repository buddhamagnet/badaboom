Rails.application.routes.draw do

  root 'users#index'

  resources :users do
    resources :feed_items
  end
end
