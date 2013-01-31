Flip::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  
  match 'user/transactions' => "transactions#index"
  match 'order/transactions' => "transactions#index"

  match 'admin' => "admin/products#index"
  post '/admin/product_details/:id' => 'admin/product_details#create' 
  devise_for :users, :path => '', :path_names => { :sign_in => 'LogIn', :sign_out => 'LogOut' }
  namespace :admin do
    resources :categories, :users, :products, :brands, :sessions, :images, :product_attributes, :product_details, :varients, :colours, :sizes
    resources :orders do
      post 'dispatch', :on => :member
      post 'delivered', :on => :member
    end
    resources :prototypes do
      get 'create_details', :on => :member
    end
  end
  resources :users, :products, :line_items, :addresses, :reviews, :ratings, :categories
  namespace 'user' do
    resources :transactions, :only => [:index]
  end
  namespace 'order' do
    resources :transactions, :only => [:index]
  end

  resources :orders do
    get 'cart', :on => :collection
    post 'add_line_item', :on => :collection
    post 'cancelled', :on => :member
    post 'pay', :on => :member
    get 'confirm', :on => :member
  end
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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
