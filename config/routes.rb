Rails.application.routes.draw do
  devise_for :users,
    controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users do
    resources :questions
  end
  resources :exams
  root to: "exams#index"
  namespace :admin do
    resources :users
    resources :subjects
    resources :questions
    resources :exams
    root to: "subjects#index"
  end
end
