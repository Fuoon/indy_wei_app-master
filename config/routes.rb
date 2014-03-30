IndyWeiApp::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :relationships
  resources :image_attachment
  resources :articles do
    resources :article_comments do
      member do
        put "like", to: "article_comments#like"
        put "unlike", to: "article_comments#unlike"
        match '/delete', to: 'article_comments#destroy', via: 'delete'
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
        match '/delete', to: 'game_comments#destroy', via: 'delete'
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
  match '/search_articles', to: 'articles#search', via: 'get'
  match '/search_users', to: 'users#search', via: 'get'
  match '/show_all_games', to: 'games#show_all_games', via: 'get'
  match '/users/:id/admin', to: 'users#admin', via: 'post'

  match '/follow_without_signed_in', to: 'games#follow_without_signed_in', via: 'get'
  match '/show_all_action_games', to: 'games#show_all_action_games', via: 'get'
  match '/show_all_arcade_games', to: 'games#show_all_arcade_games', via: 'get'
  match '/show_all_adventure_games', to: 'games#show_all_adventure_games', via: 'get'
  match '/show_all_puzzle_games', to: 'games#show_all_puzzle_games', via: 'get'
  match 'show_all_rpg_games', to: 'games#show_all_rpg_games', via: 'get'
  match 'show_all_shooter_games', to: 'games#show_all_shooter_games', via: 'get'
  match 'show_all_sport_games', to: 'games#show_all_sport_games', via: 'get'
  match 'show_all_strategy_games', to: 'games#show_all_strategy_games', via: 'get'
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
