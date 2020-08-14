Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"

  get '/' => 'home#index', as: :home

  devise_for :users
  namespace :drivers do
    get :check_punctuation_form
    get :check_punctuation
    get :track_request_form
    get :track_request
  end

  namespace :vehicles do
    get :negative_certificate_form
    get :negative_certificate
    get :unlicensed_form
    get :unlicensed
  end
  namespace :infractions do
    get :assessment_defense_form
    get :assessment_defense
    get :infraction_result_form
    get :infraction_result
  end
end
