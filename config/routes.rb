Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :drivers do
    get :check_punctuation
    get :track_request
  end

  namespace :vehicles do
    get :negative_certificate
    get :unlicensed
  end
  namespace :infractions do
    get :assessment_defense
    get :infraction_result
  end
end
