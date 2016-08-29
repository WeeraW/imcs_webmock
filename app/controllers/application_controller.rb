class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_devise_parameters, if: :devise_controller?
  before_action :set_title

  add_flash_types :warning, :title

  rescue_from ActionController::RoutingError, with: :render_not_found
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def render_not_found
    respond_to do |format|
      format.html { render template: 'errors/page_not_found', status: 404 }
    end
  end

  protected

  def set_title
    flash[:title] = "Core\" Caralluma #{current_staff.nil? ? '' : current_staff.class.to_s + '::' + controller_name.titleize}"
  end

  def configure_devise_parameters
    added_attrs = [:staff_account, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def after_sign_in_path_for(resource)
    if current_staff.has_role? :warehouse
      staffs_warehouses_orders_path
    elsif current_staff.has_role? :sale
      staffs_sales_orders_path
    elsif current_staff.has_role? :accountant
      staffs_accountings_payments_path
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    new_staff_session_path
  end

  def skip_bullet
    Bullet.enable = false
    yield
  ensure
    Bullet.enable = true
  end
end
