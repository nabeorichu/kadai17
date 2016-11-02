Rails.application.routes.draw do
  resources :blogs do
    collection do
      get 'draft'
      get 'dropbox'
    end
    member do
      get 'drop'
      post 'drop'
      patch 'drop'
    end

  end
  root 'blogs#index'

end
