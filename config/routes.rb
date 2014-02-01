Rails.application.routes.draw do
  devise_for :users
  root to: 'static_pages#home'

  get '/dashboard' => 'static_pages#dashboard'

  resources :subproject_implementation_plans
  resources :subprojects
  resources :request_for_fund_releases

  resources :regions
  resources :provinces
  resources :municipalities
  resources :barangays

  scope '/admin' do
    get '/index', to: 'admin#index', as: 'admin_index'
    get '/news', to: 'admin#news', as: 'admin_news'
  end
end
