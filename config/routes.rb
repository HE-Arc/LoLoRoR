Rails.application.routes.draw do
  root 'information#index'
  
  #News routes, only admins can CRUD on the news, users can only read (index, show)
  resources :information, except: [:index]
  
  get '/:pageNumber' => 'information#index'
  
  devise_for :users, controllers: {                                          
    sessions: 'users/sessions',
    registrations: 'users/registrations'
      }  
  
  get 'users' => 'users#showCurrentUser'
  
  #API account routes
  get 'accounts/:region/:idLoL' => 'accounts#show', as: 'account'
  get 'search/accounts/' => 'accounts#searchAccounts', as: 'accounts_search'
  
  resources :trackgroups, except: [:index]
  
  resources :dashboards, except: [:index]
 
  #Manage accounts (show, create, destroy) for the current user
  get 'users/accounts' => 'accounts#showUserAccounts'
  post 'users/accounts' => 'accounts_users#create'
  delete 'users/accounts' => 'accounts_users#destroy'
  
  #Manage trackgroups (show, create, destroy) for the current user
  get 'users/trackgroups' => 'trackgroups#showUserTrackgroups'
  post 'users/trackgroups' => 'accounts_trackgroups#create'
  post 'users/trackgroups/:id' => 'accounts_trackgroups#createAPI'
  delete 'users/trackgroups' => 'accounts_trackgroups#destroy'
  
  #Manage dashboards for the current user
  get 'users/dashboards' => 'dashboards#showUserDashboards'
  post 'users/dashboards' => 'dashboards#create'
  delete 'users/dashboards' => 'dashboards#destroy'
 
  get 'about' => 'pages#about'
  get 'contact' => 'pages#contact'
  
  #Modules routes
  scope 'dashboards/:dashID/modules' do
    resources :match_history_modules
  end
  
  #Admin routes
  get 'users/all' => 'users#index', as: 'users_all'
  get 'users/show/:id' => 'users#show', as: 'user'
  delete 'users/destroy/:id' => 'users#destroy', as: 'destroy_user'

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
