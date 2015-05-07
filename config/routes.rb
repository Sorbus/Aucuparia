Rails.application.routes.draw do
    root 'welcome#index'
    get 'about' => 'welcome#about'
    get '/fetch' => 'welcome#fetch', :as => 'fetch'
    
    concern :paginatable do
        get '(page/:page)', :action => :index, :on => :collection, :as => ''
    end
    
    # user stuff
    devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "users/registrations" }
    resources :users, :only => [:index, :show, :edit, :update], :concerns => :paginatable
    
    resource :profile, :only => [:index, :edit, :update] do
        root 'profiles#index'
    end
    
    resources :categories
    resources :items, :concerns => :paginatable do
        resources :comments, :only => [:new, :create, :edit, :update, :destroy]
        post '/publish' => 'items#publish'
    end
    
    resources :messages, :only => [:destroy, :index] do
        collection do
            get 'refresh'
        end
    end
    
    resources :tags, :only => [:index, :show], :param => :tag, :concerns => :paginatable
    
    namespace :admin do
        root 'admin#index'
        resources :core, :only => [:edit, :update]
        resources :menus, :only => [:index, :update, :create, :new]
#        resource :icons, :only => [:index, :update, :create]
        resources :logolink, :only => [:index, :update, :create, :destroy]
    end
    
    match '*unmatched_route', :to => 'application#raise_not_found!', :via => :all
end
