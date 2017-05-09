Rails.application.routes.draw do
  mount Raddocs::App => "/docs"

  root to: 'home#show'

  scope module: 'api' do
    mount_devise_token_auth_for 'User', at: 'auth'
    namespace :v1 do
      resources :physicians, shallow: true do
        resources :patients
      end
      resources :states, shallow: true do
        resources :licenses, shallow: true do
          resources :vehicles
          resources :locations, shallow: true do
            resources :rooms
          end
          resources :growing_stages
        end
        resources :cities
      end
      resources :strains
      resources :regulations
      resources :inventory_types
      resources :notes
      resources :users, only: [:index, :show]
    end
  end

end
