ApiServer::Application.routes.draw do
  scope 'user/' do
    post 'login' => 'users#login'
    post 'view' => 'users#view'
    post 'update' => 'users#update'
    post 'library' => 'users#show_library'
    post 'wishlist' => 'users#show_wishlist'
    post 'wishlist/add' => 'users#add_to_wishlist'
    post 'library/add' => 'users#add_to_library'
    post 'wishlist/delete' => 'users#delete_from_wishlist'
    post 'foo' => 'users#foo'
    post 'signup' => 'users#signup'
    get  'friendlist' => 'users#friendlist'
    post 'friendlist/library/addtowishlist' => 'users#add_to_wishlist'    
  end
  
  scope 'school/' do
    post 'booklist' => 'schools#booklist'
    post 'signup' => 'schools#signup'
    post 'view' => 'schools#view'
    post 'update' => 'schools#update'    
    post 'booklist/add' => 'schools#add'
  end
  
  scope 'bookshop/' do
    post 'booklist/add' => 'bookshops#add'
    post 'booklist' => 'bookshops#booklist'
    post 'view' => 'bookshops#view'
    post 'signup' => 'bookshops#signup'
    post 'update' => 'bookshops#update'
  end

  scope 'RestServer/' do
   scope ':method/' do
    get ':username/:password' => 'server#test'
    
    end 
  
  end
  get 'server/log' => 'server#log'
  root 'server#test'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
