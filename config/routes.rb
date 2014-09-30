Rails.application.routes.draw do
  get 'feed_item/index'

  get 'feed_item/show'

  get 'user/index'

  get 'user/new'

  get 'user/create'

  get 'user/show'

  get 'user/edit'

  get 'user/update'

  get 'user/destroy'

  resources :users do
    resources :feed_items
  end
end
