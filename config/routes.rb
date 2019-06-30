Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
      end
      namespace :merchants do
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
        get '/revenue', to: 'revenue#index'
        get '/random', to: 'random#index'
      end
      resources :merchants, only: [:index, :show] do
        get '/revenue', to: 'revenue#show'
        get '/favorite_customer', to: 'favorite_customers#show'
        get '/items', to: 'merchant_items#show'
        get '/invoices', to: 'merchant_invoices#show'
      end
      resources :customers, only: [:index, :show] do
        get '/favorite_merchant', to: 'favorite_merchants#show'
      end
      resources :items, only: [:index, :show] do
        get 'best_day', to: 'best_day#show'
      end
      resources :invoices, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
    end
  end
end
