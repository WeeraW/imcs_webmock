Rails.application.routes.draw do
  # root to: 'devise/sessions#new'
  # devise_for :distributors
  devise_for :staffs
  namespace :staffs do
    namespace :sales do
      resources :fullfilled_orders, only: [:index]
      resources :orders, only: [:index, :show, :new, :create, :edit, :update] do
        resources :payments, only: [:index, :show, :new, :create, :edit, :update]
      end
      resources :products, only: [:index, :show, :new, :create, :edit, :update]
    end
    namespace :warehouses do
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
      resources :payments, only: [:index, :edit, :update]
      resources :approved_payments, only: [:index, :edit, :update]
      resources :orders, only: [:index, :new, :create, :edit, :update]
    end
  end
  as :staff do
    # Define routes for Staff within this block.
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
