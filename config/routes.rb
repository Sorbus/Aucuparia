Rails.application.routes.draw do
	# root pages
	root 'welcome#index'
	get 'about' => 'welcome#about'
	get '/fetch' => 'welcome#fetch', :as => 'fetch'
	
	# user stuff
	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations" }
	resources :users, :only => [:index, :show, :edit, :update]
	
	resource :profile, :only => [:index, :edit, :update] do
		root 'profiles#index'
	end
	
	resources :categories
	resources :items do
		resources :comments, :only => [:new, :create, :edit, :update, :destroy]
		post '/publish' => 'items#publish'
	end
	
	resources :messages, :only => [:destroy, :index]
	
	resources :tags, :only => [:index, :show], :param => :tag
	
	namespace :admin do
		root 'admin#index'
		resources :core, :only => [:edit, :update]
		resources :menus, :only => [:index, :update, :create, :new]
#		resource :icons, :only => [:index, :update, :create]
		resources :logolink, :only => [:index, :update, :create, :destroy]
	end
	
	match '*unmatched_route', :to => 'application#raise_not_found!', :via => :all
end
