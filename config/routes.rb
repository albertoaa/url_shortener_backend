Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :links
      resources :redirects
      get 'count', to: 'links#count', as: 'count'
    end
  end
end
