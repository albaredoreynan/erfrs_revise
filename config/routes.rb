Rails.application.routes.draw do
  root to: 'static_pages#home'

  get '/dashboard' => 'static_pages#dashboard'

  resources :subproject_implementation_plans
  resources :subprojects
  resources :request_for_fund_releases
end
