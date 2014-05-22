SpartanLimo::Application.routes.draw do
  devise_for :users
  
  get "/braintree/new_transaction", to: "braintree#new_transaction", as: "new_transaction"
  post "/braintree/submit_transaction", to: "braintree#submit_transaction", as: "submit_transaction"

  get "trips/new_non_user", to: "trips#new_non_user", as: "new_non_user_trip"
  post "trips/create_non_user_trip",to: "trips#non_user_create", as: "trips"
  get "trips/non_user_show/:id", to: "trips#non_user_show", as: "non_user_show"
  get "trips/toggle_payment/:id", to: "trips#toggle_payment", as: "toggle_trip_payment"
  get "trips/confirm_with_customer/:id", to: "trips#confirm_with_customer", as: "customer_confirmation"
  post "trips/send_confirmation/:id", to: "trips#send_confirmation", as: "send_customer_confirmation"
  get "trips/add_payment/:id", to: "trips#add_payment", as: "add_payment"
  post "trips/process_payment", to: "trips#process_payment", as: "process_payment"

  resources :users, only: [:index, :show, :destroy] do 
    resources :trips, only: [:index, :new, :create, :show]
    resources :trips, only: [:edit, :update, :destroy], shallow: true do
      resources :extra_charges
    end
  end

  get "admins/menu", to: "admins#menu", as: "admin_menu"
  get "admins/index", to: "admins#index", as: "all_admins"
  get "admins/new", to: "admins#new", as: "new_admin"
  post "admins/create", to: "admins#create", as: "create_admin"
    
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root to: "home#index"
  get "home/disclaimer" , to: "home#disclaimer", as: "disclaimer"
  get "home/privacy_notice", to: "home#privacy_notice", as: "privacy_notice"
  get "home/terms", to: "home#terms", as: "terms"
  
  get "/rates/calculate", to: "rates#calculate", as: "calculate_rate"
  get "/rates/hourly_quote", to: "rates#hourly_quote", as: "hourly_quote"
  
  resources :rates
  resources :cars
  get "messages/:id/toggle_answered", to: "messages#toggle_answered", as: "toggle_answered"
  resources :messages, only: [:create, :destroy, :show, :index]





  
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
