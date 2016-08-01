Rails.application.routes.draw do
  devise_for :distributors
  devise_for :staffs
  as :staff do
    # Define routes for Staff within this block.
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
