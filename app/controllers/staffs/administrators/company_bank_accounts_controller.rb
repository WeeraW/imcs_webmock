class Staffs::Administrators::CompanyBankAccountsController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_bank_account!, only: [:edit, :update]
  def index
    @bank_accounts = Accounting::CompanyBankAccount.page(params[:page]).per(params[:per_page])
  end

  def new
    @bank_account = Accounting::CompanyBankAccount.new
  end

  def create
    @bank_account = Accounting::CompanyBankAccount.new(company_bank_account_params)

    render_or_redirect_on_save 'new'
  end

  def edit; end

  def update
    @bank_account.update(company_bank_account_params)

    render_or_redirect_on_save 'edit'
  end

  private

  def render_or_redirect_on_save(template)
    if @bank_account.save
      respond_to do |format|
        format.html { redirect_to staffs_administrators_banks_path }
      end
    else
      render template
    end
  end

  def company_bank_account_params
    params.fetch(:accounting_company_bank_account).permit(:code, :display_name, :accounting_bank_branch_id)
  end

  def find_bank_account!
    @bank_account = Accounting::CompanyBankAccount.find(params[:id])
  end
end
