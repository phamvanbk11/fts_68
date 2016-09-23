Rails.application.routes.draw do
  devise_for :users
  resources :exams
  root to: "exams#index"
  namespace :admin do
    resources :subjects
    root to: "subjects#index"
  end
end
