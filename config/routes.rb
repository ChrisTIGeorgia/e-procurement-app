BootstrapStarter::Application.routes.draw do

	#--------------------------------
	# all resources should be within the scope block below
	#--------------------------------
	scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do

		match '/admin', :to => 'admin#index', :as => :admin, :via => :get
    match '/user', :to => 'user#index', :as => :user, :via => :get
  
		devise_for :users, :controllers => { :sessions => "users/sessions", :registrations => "users/registrations" }, :path_names => { :sign_up => "register" }

    namespace :admin do
      resources :users
    end

    resources :tenders
    resources :organizations

    match '/organization/search_procurer' => 'organizations#search_procurer'
    match '/organization/search' => 'organizations#search'
    match '/tender/search' => 'tenders#search'
    match '/tenders/index' => 'tenders#index'
    match '/procurer' => 'organizations#show_procurer'
    match '/watch_tender/subscribe' => 'watch_tender#subscribe'
    match '/watch_tender/unsubscribe' => 'watch_tender#unsubscribe'
    match '/cpv_tree/showCPVtree' => 'cpv_tree#showCPVTree'
    match ':controller/:action'

    match '/build_user_data', :to => 'root#build_user_data', :as => :build_user_data, :via => :get
    match '/generate_cpv_codes', :to => 'root#generate_cpv_codes', :as => :generate_cpv_codes, :via => :get
    match '/process_full_scrape', :to => 'root#process_full_scrape', :as => :process_full_scrape, :via => :get
    match '/process_incremental_scrape', :to => 'root#process_incremental_scrape', :as => :process_incremental_scrape, :via => :get

		match '/process_json', :to => 'root#process_json', :as => :process_json, :via => :get
		root :to => 'root#index'
	  
	end

	match '', :to => redirect("/#{I18n.default_locale}") # handles /
	
end
