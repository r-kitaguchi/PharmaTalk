Rails.application.routes.draw do
  root to: 'pages#index'
  get :concepts, to: 'concepts#index'

  devise_for :pharmacists, controllers: {
                            sessions:      'pharmacists/sessions',
                            passwords:     'pharmacists/passwords',
                            registrations: 'pharmacists/registrations'
                          }, path_names: {
                            sign_in: 'login', sign_out: 'logout'
                          }
  devise_for :students, controllers: {
                          sessions:      'students/sessions',
                          passwords:     'students/passwords',
                          registrations: 'students/registrations'
                        }, path_names: {
                          sign_in: 'login', sign_out: 'logout'
                        }

  devise_scope :pharmacist do
    post 'pharmacists/guest_log_in', to: 'pharmacists/sessions#new_guest'
  end

  devise_scope :student do
    post 'students/guest_log_in', to: 'students/sessions#new_guest'
  end

  resources :pharmacists, only: :show
  resources :students, only: :show
  resources :pharmacist_profiles, except: [:index, :destroy] do
    collection do
      get 'search'
    end
  end
  resources :student_profiles, except: [:index, :destroy]

  resources :relationships, only: [:create, :update, :destroy]

  resources :rooms, only: [:create, :show, :destroy] do
    resources :messages, only: :create
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
