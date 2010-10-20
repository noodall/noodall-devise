require 'noodall/routes'
Dummy::Application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :users
  end
  root :to => "home#index"
end
Noodall::Routes.draw Dummy::Application
