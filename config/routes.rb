IndyWeiApp::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :relationships
  resources :articles do
    resources :article_comments do
      member do
        put "like", to: "article_comments#like"
        put "unlike", to: "article_comments#unlike"
        put "dislike", to: "article_comments#dislike"
        put "undislike", to: "article_comments#undislike"
      end
    end
  end
  resources :games do 
    member do
      put "like", to: "games#like"
      put "unlike", to: "games#unlike"
      put "dislike", to: "games#dislike"
      put "undislike", to: "games#undislike"
    end
    resources :game_comments do
      member do
        put "like", to: "game_comments#like"
        put "unlike", to: "game_comments#unlike"
        put "dislike", to: "game_comments#dislike"
        put "undislike", to: "game_comments#undislike"
      end
    end  
  end

  root 'home_page#home'
  match '/library', to: 'library#library', via: 'get'
  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/contact', to: 'static_pages#contact', via: 'get'
  match '/privacy', to: 'static_pages#privacy', via: 'get'
  match '/term', to: 'static_pages#term', via: 'get'
  match '/uploaded_games', to: 'games#uploaded_games', via: 'get'
  match '/search_games', to: 'games#search', via: 'get'
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
