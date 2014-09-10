Rails.application.routes.draw do
  #authenticated :super_user do
  #  root to: 'static_pages#dashboard', as: 'authenticated_root'
  #end

  root to: 'static_pages#landing_page'

  get '/landing_page' => 'static_pages#landing_page'
  get '/dashboard' => 'static_pages#dashboard'

  resources :subproject_implementation_plans
  resources :subprojects
  resources :request_for_fund_releases do
    get :select_subproject, on: :collection
    get :obr, on: :collection
    get :dv, on: :collection
    get :remove_signatory, on: :collection
    get :request_for_fund_pdf, on: :collection
    post :rfr_signatory, on: :collection
  end

  resources :cgdps, only: :index
  resources :regional_officers

  # resources :cgdps, path: 'community_grants_disburesment_plans'
  resources :cgdps
  
  resources :regions
  resources :provinces
  resources :municipalities do
    get :edit_cgdp, on: :collection
    get :create_cgdp, on: :collection
  end
  resources :barangays
  resources :groups
  resources :fund_sources
  resources :fund_allocations
  resources :news_informations
  resources :designations
  resources :muni_fund_allocations
  
  resources :reports do
    get :soe_reports, on: :collection
    get :soe_adb_reports, on: :collection
    get :mga_reports, on: :collection
    get :cg_reports, on: :collection
    get :cash_program_reports, on: :collection
  end
  
  get '/download_file', to: 'reports#download_file', as: 'download_file'

  scope '/admin' do
    get '/index', to: 'admin#index', as: 'admin_index'
    get '/news', to: 'admin#news', as: 'admin_news'
  end

  devise_for :users, :path_prefix => 'dswd'
  resources :users


  # ajax
  get '/display_group', to: 'subprojects#display_group', as:'display_group'
  
  get '/update_exchange_rate', to: 'reports#update_exchange_rate', as:'update_exchange_rate'

  get '/update_remark', to: 'reports#update_remark', as:'update_remark'

  get '/update_fund_source', to: 'municipalities#update_fund_source', as:'update_fund_source'
  
  get '/display_designation', to: 'request_for_fund_releases#display_designation', as:'display_designation'
  
  get '/assigned_fund_source', to: 'municipalities#assigned_fund_source', as: 'assigned_fund_source' 

end
