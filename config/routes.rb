Rails.application.routes.draw do
  # devise_for :distributors
  devise_for :staffs
  devise_scope :staff do
    root to: 'devise/sessions#new'
  end

  namespace :staffs do
    namespace :reports do
      resources :kpis, only: [:index]
      resources :staff_commissions, only: [:index]
      resources :incentives, only: [:index]
    end
    namespace :administrators do
      resources :freight_providers, except: [:show, :destroy]
      resources :staffs, except: [:show, :destroy]
      resources :banks, except: [:show, :destroy] do
        resources :bank_branches, except: [:show, :destroy]
      end
      resources :company_bank_accounts, except: [:show, :destroy]
    end
    namespace :sales do
      resources :create_orders, except: [:index, :destroy]
      resources :fullfilled_orders, only: [:index]
      resources :orders, only: [:index, :show, :new, :create, :edit, :update] do
        resources :payments, only: [:index, :show, :new, :create, :edit, :update]
      end
      resources :products, only: [:index, :show, :new, :create, :edit, :update]
    end
    namespace :warehouses do
      get 'inventory_movements_reports/inventory_movements', 'inventory_movements_reports#inventory_movements'
      resources :approved_shipping_orders, only: [:index]
      resources :inventory_movements, only: [:create]
      resources :shipping_addresses, only: [:update]
      get :pdf_address_renders, to: 'pdf_renders#address_labels', defaults: { format: 'pdf' }
      get :pdf_stock_render, to: 'pdf_renders#stock_receipts', defaults: { format: 'pdf' }
      resources :orders, only: [:index, :show, :new, :create, :edit, :update]
      resources :suppliers, only: [:index, :show, :new, :create, :edit, :update]
      resources :inventories, only: [:index, :show, :new, :create, :edit, :update] do
        resources :item_lots, only: [:index, :show, :new, :create, :edit, :update]
      end
    end
    namespace :accountings do
      resources :saler_orders, only: [:update]
      resources :payments, only: [:index, :edit, :update]
      resources :approved_payments, only: [:index, :edit, :update]
      resources :orders, only: [:index, :new, :create, :edit, :update]
    end
  end
  get '*not_found' => 'application#render_not_found'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
