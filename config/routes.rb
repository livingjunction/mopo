Mopo::Application.routes.draw do

  resources :activities


  resources :categories, :only => [:show] do
    resources :assignments, :name_prefix => "category_"
  end

  resources :assignments do
    resources :projects, :name_prefix => "assignment_", :only => [:index, :new, :create]
    resources :scraps, :name_prefix => "assignment_", :only => [:new]
    collection { post :sort }
  end

  resources :projects do
     resources :scraps, :name_prefix => "project_", :only => [:index, :new]
  end

  resources :scraps do
    resources :comments,  :name_prefix => "scrap_"
  end

  resources :assets, :only => [:create, :destroy]
  resources :scrap_images, :controller => "assets", :type => "Scrap::Image"
  resources :scrap_videos, :controller => "assets", :type => "Scrap::Video"
  resources :scrap_audios, :controller => "assets", :type => "Scrap::Audio"
  resources :scrap_files, :controller => "assets", :type => "Scrap::File"

  resources :links, :only => [:create, :destroy]

  resources :comments, :only => [:show, :create, :destroy]
  resources :likes, :only => [:create, :destroy]
  resources :flags, :only => [:show, :create, :update, :destroy]

  resources :notifications, :only => [:index, :update]

  devise_for :users
  resources :users, :only => [:index, :show, :edit, :update]

  match "home" => "home#index"
  match "tour" => "home#tour"
  root :to => "home#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
