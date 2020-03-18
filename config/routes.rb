Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # resources :links
      # resources :redirect
      scope '/links', as: 'links' do
        post 'create', to: 'links#create', as: 'create'
        get 'count', to: 'links#count', as: 'count'
        post 'get', to: 'links#get', as: 'get'
        if Rails.env.development? || Rails.env.test?
          get 'index', to: 'links#index', as: 'index'
        end
      end
      get '/:shortened', to: 'redirect#redirect', as: 'redirect'
    end
  end
end
