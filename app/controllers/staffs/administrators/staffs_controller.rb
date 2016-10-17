class Staffs::Administrators::StaffsController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_staff!, only: [:edit, :update]
  before_action :new_staff, only: [:new]
  def index
    @staffs = Staff.page(params[:page]).per(params[:per_page])
  end

  def new; end

  def create
    @staff = Staff.new(staff_params)
    save_and_respond
    create_roles
  end

  def edit; end

  def update
    @staff.update(update_staff_params)
    update_password_if_password_provide
    create_roles
    if @staff.valid?
      respond_to do |format|
        format.html { redirect_to staffs_administrators_staffs_path }
      end
    else
      render 'edit'
    end
  end

  private

  def update_password_if_password_provide
    return if staff_params[:password].blank?
    @staff.update(password_staff_params)
  end

  def save_and_respond
    if @staff.save
      respond_to do |format|
        format.html { redirect_to staffs_administrators_staffs_path }
      end
    else
      render 'new'
    end
  end

  # TODO: Too many touches database need refactoring!!
  def create_roles
    @staff.roles.destroy_all
    staff_roles_params.delete_if(&:blank?).each do |role_id|
      @staff.add_role Role.find(role_id).name.to_sym
    end
  end

  def new_staff
    @staff = Staff.new
  end

  def find_staff!
    @staff = Staff.find(params[:id])
  end

  def password_staff_params
    params.fetch(:staff).permit(:password, :password_confirmation)
  end

  def update_staff_params
    params.fetch(:staff).permit(:employee_code, :email, :staff_account, :first_name, :last_name, :nickname, :is_active)
  end

  def staff_params
    params.fetch(:staff).permit(:employee_code, :email, :staff_account, :first_name, :last_name, :nickname, :password, :password_confirmation, :is_active)
  end

  def staff_roles_params
    params.fetch(:staff)[:role_ids]
  end
end
