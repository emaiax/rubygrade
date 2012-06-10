# See how all your routes lay out with "rake routes"
Rubygrade::Application.routes.draw do

  resources :categories
  resources :gradations
  resources :assignments
  resources :attendances
  resources :students
  resources :courses
  resources :registrations

  # RESTful rewrites
  match 'signup',                    :to => "users#new"
  match 'register',                  :to => "users#create"
  match 'activate/:activation_code', :to => "users#activate"
  match 'login',                     :to => "sessions#new"
  match 'logout',                    :to => "sessions#destroy", :method => :delete

  match 'users/troubleshooting',                     :to => "users#trobleshooting"
  match 'users/forgot_password',                     :to => "users#forgot_password"
  match 'users/reset_password/:password_reset_code', :to => "users#reset_password"
  match 'users/forgot_login',                        :to => "users#forgot_login"
  match 'users/clueless',                            :to => "users#clueless"

  resources :users do
    member do
      get :edit_password
      put :update_password
      get :edit_email
      put :update_email
      get :edit_avatar
      put :update_avatar
    end
  end

  resource :session

  # Profiles
  resources :profiles

  # Administration
  namespace :admin do
    root :to => "dashboard#index"
    resources :settings
    resources :users do
      member do
        put :suspend
        put :unsuspend
        put :activate
        delete :purge
        put :reset_password
      end
      collection do
        get :pending
        get :active
        get :suspended
        get :deleted
      end
    end
  end

  # Dashboard as the default location
  root :to => "dashboard#index"
end
