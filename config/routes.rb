Rails.application.routes.draw do
  authenticated :super_user do
    root to: 'static_pages#dashboard', as: 'authenticated_root'
  end

  root to: 'static_pages#home'

  get '/dashboard' => 'static_pages#dashboard'

  resources :subproject_implementation_plans
  resources :subprojects
  resources :request_for_fund_releases do
    get 'select_subproject', on: :collection
  end

  resources :cgdps, only: :index

  resources :cgdps, path: 'community_grants_disburesment_plans'
  
  resources :regions
  resources :provinces
  resources :municipalities
  resources :barangays
  resources :groups
  resources :fund_sources
  resources :fund_allocations
  resources :news_informations
  resources :designations
  
  resources :reports do
    get :soe_reports, on: :collection
    get :mga_reports, on: :collection
    get :cg_reports, on: :collection
    get :cash_program_reports, on: :collection
  end
  
  get '/download_file', to: 'reports#download_file', as: 'download_file'

  scope '/admin' do
    get '/index', to: 'admin#index', as: 'admin_index'
    get '/news', to: 'admin#news', as: 'admin_news'
  end



  devise_for :users
  resources :users

end
