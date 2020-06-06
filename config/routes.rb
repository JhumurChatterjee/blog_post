Rails.application.routes.draw do
  resources :posts
  devise_for :users, controllers: { registrations: "registrations" }

  devise_scope :user do
    get "check_email_duplicacy", to: "registrations#check_email_duplicacy"
  end

  root "home#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
