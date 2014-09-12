MovieGroks::Application.routes.draw do
 root 'static_pages#home'
 resources :access, only: [:signin, :signout]

 # other routes ...
   get '/' => 'static_pages#home'
   get 'about' => 'static_pages#about'
   get 'help' => 'static_pages#help'
   get 'faqs' => 'static_pages#faqs'
   get 'terms' => 'static_pages#terms'
   get 'privacy' => 'static_pages#privacy'
   get 'contact' => 'static_pages#contact'

   match 'signin', to: 'access#signin', via: [:get, :post]
   match 'signout', to: 'access#signout', via: 'delete'
   match '/signup', to: 'users#new', via: [:get, :post]

  resources :groks, :profiles, :users, :notifiers, :themes, :movies

  resources :groks do
    member do
      post 'vote_for'
      delete 'unvote_for'
    end
  end

  match ':controller(/:action(/:id))', :via => [:get, :post]
  
  get 'processing_audio' => 'groks#processing_audio'


end

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
