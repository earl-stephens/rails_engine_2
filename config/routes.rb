Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        get '/revenue', to: 'revenue#show'
        get '/favorite_customer', to: 'favorite_customers#show'
      end
      resources :customers, only: [:index, :show] do
        get '/favorite_merchant', to: 'favorite_merchants#show'
      end
      resources :items, only: [:index, :show]
      resources :invoices, only: [:index, :show]
      resources :transactions, only: [:index, :show]
      resources :invoice_items, only: [:index, :show]
    end
  end
end
