Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users

  root to: 'home#index'

  namespace :drivers do
    get :check_punctuation_form
    get :check_punctuation
    get :track_request_form
    get :track_request
  end
  resources :vehicles
  get 'negative_certificate_form', to: 'vehicles#negative_certificate_form', as: :vehicles_negative_certificate_form
  get 'unlicensed_form', to: 'vehicles#unlicensed_form', as: :vehicles_unlicensed_form
  get 'negative_certificate', to: 'vehicles#negative_certificate', as: :vehicles_negative_certificate
  get 'unlicensed', to: 'vehicles#unlicensed', as: :vehicles_unlicensed

  namespace :infractions do
    get :assessment_defense_form
    get :assessment_defense
    get :infraction_result_form
    get :infraction_result
  end
end
