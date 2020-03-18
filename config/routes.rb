Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :links
      resources :redirect
      get 'count', to: 'links#count', as: 'count'
      post 'get', to: 'links#get', as: 'get'
    end
  end
  get '/:shortened', to: 'redirect#redirect', as: 'redirect'
end
