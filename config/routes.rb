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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
