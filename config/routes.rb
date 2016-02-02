Rails.application.routes.draw do
  # Mount sidekiq admin.
  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV['SIDEKIQ_USERNAME'] && password == ENV['SIDEKIQ_PASSWORD']
  end if Rails.env.production? || Rails.env.staging?
  mount Sidekiq::Web, at: '/queue'

  mount StripeEvent::Engine, at: '/stripe-callback'

  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
    passwords:          'users/passwords',
    sessions:           'api/sessions',
    registrations:      'api/registrations',
    invitations:        'api/invitations',
    omniauth_callbacks: 'omniauth_callbacks'
  }
  namespace :api do
    resources :users do
     collection do
        get :current
        get :exists
      end
    end
    resources :ideas do
      collection do
        get :draft
        get :published
      end

      member do
        post :publish
        post :unpublish
      end

      resources :problems
      resources :comments
      resources :channels
      resources :financial_entries, only: [:create, :update, :destroy]
      resources :funding_options
      resources :founders
      resources :user_ideas, only: [:index]

      post   'vote' => 'votes#create'
      delete 'vote' => 'votes#destroy'
    end
  end

  # Word export.
  resources :ideas, only: :show

  # Stripe callback.
  resources :payments, only: [:create]

  root 'home#index'

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
