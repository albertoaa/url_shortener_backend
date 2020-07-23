Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # resources :links
      # resources :redirect
      scope '/links', as: 'links' do
        post 'store', to: 'links#store', as: 'store'
        get 'count', to: 'links#count', as: 'count'
        get 'top100', to: 'links#top_100', as: 'top100'
        post 'get', to: 'links#get', as: 'get'
        if Rails.env.development? || Rails.env.test?
          get 'index', to: 'links#index', as: 'index'
        end
      end
    end
  end
  get '/:shortened', to: 'redirect#redirect', as: 'redirect'
end
