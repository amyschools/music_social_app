Rails.application.routes.draw do




#mailboxer
  resources :conversations, only: [:index, :show, :destroy] do
    collection do
      delete :empty_trash
    end
    member do
      post :reply
      post :restore
      post :mark_as_read
      post :mark_as_unread
    end
  end



  resources :messages, only: [:new, :create]

  resources :bandtogethers
  devise_for :users, controllers: {registrations: "registrations", omniauth_callbacks: "omniauth_callbacks"}


  resources :relationships, only: [:create, :destroy]

  resources :concerts do
      # GET /concerts/:concert_id/map_locations
      get 'map_location'
    end

  resources :users do
    member do
      get :following, :followers
    end
  end

  mount Commontator::Engine => '/commontator'


  get 'relationships', to: 'relationships#create'

  get '/bandtogethers/:id/join(.:format)' => 'users#join'
  get '/bandtogethers/:id/leave(.:format)' => 'users#leave'
  get '/bandtogethers/:id/invite' => 'bandtogethers#invite'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  authenticated do
    root :to => 'dashboard#index', as: :authenticated
  end

  root 'concerts#index'

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
