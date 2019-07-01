Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
        get '/find', to: 'search#show'
      end
      namespace :merchants do
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
        get '/revenue', to: 'revenue#index'
        get '/random', to: 'random#index'
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
      end
      namespace :invoice_items do
        get '/find', to: 'search#show'
      end
      namespace :transactions do
        get '/find', to: 'search#show'
      end
      namespace :customers do
        get '/find', to: 'search#show'
      end
      resources :merchants, only: [:index, :show] do
        get '/revenue', to: 'revenue#show'
        get '/favorite_customer', to: 'favorite_customers#show'
        get '/items', to: 'merchant_items#show'
        get '/invoices', to: 'merchant_invoices#show'
      end
      resources :customers, only: [:index, :show] do
        get '/favorite_merchant', to: 'favorite_merchants#show'
        get '/invoices', to: 'customer_invoices#show'
        get '/transactions', to: 'customer_transactions#show'
      end
      resources :items, only: [:index, :show] do
        get 'best_day', to: 'best_day#show'
        get '/invoice_items', to: 'item_invoice_items#show'
        get '/merchant', to: 'item_merchant#show'
      end
      resources :invoices, only: [:index, :show] do
        get '/transactions', to: 'invoice_transactions#show'
        get '/invoice_items', to: 'invoice_invoice_items#show'
        get '/items', to: 'invoice_related_items#show'
        get '/customer', to: 'invoice_customer#show'
        get '/merchant', to: 'invoice_merchant#show'
      end
      resources :transactions, only: [:index, :show] do
        get '/invoice', to: 'transaction_invoices#show'
      end
      resources :invoice_items, only: [:index, :show] do
        get '/invoice', to: 'invoice_item_invoices#show'
        get '/item', to: 'invoice_item_items#show'
      end
    end
  end
end
