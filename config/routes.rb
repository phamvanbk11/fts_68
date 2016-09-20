Rails.application.routes.draw do
  devise_for :users
  root to: "static_pages#home"
  namespace :admin do
    resources :subjects
    root to: "subjects#index"
  end
end
