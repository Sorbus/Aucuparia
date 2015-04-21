Rails.application.routes.draw do
	# root pages
	root 'welcome#index'
	get 'about' => 'welcome#about'
	
	# user stuff
	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations" }
	resources :users, :only => [:index, :show, :edit, :update]
	
	resource :profile, :only => [:index, :edit, :update] do
		root 'profiles#index'
	end
	
	resources :categories
	resources :items do
		resources :comments, :only => [:new, :create, :edit, :update, :destroy]
	end
	
	namespace :admin do
		root 'admin#index'
		resources :core, :only => [:edit, :update]
		resources :menus, :only => [:index, :update, :create, :new]
#		resource :icons, :only => [:index, :update, :create]
		resources :logolink, :only => [:index, :update, :create, :destroy]
	end
end
