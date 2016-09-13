class Staffs::Administrators::BankBranchesController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_bank!, except: [:destroy]
  before_action :find_bank_branch!, only: [:edit, :update]

  def index
    @bank_branches = @bank.bank_branches.page(params[:page]).per(params[:per_page])
  end

  def new
    @bank_branch = Accounting::BankBranch.new
  end

  def create
    @bank_branch = @bank.bank_branches.new(bank_branch_params)
    render_or_redirect_on_save 'new'
  end

  def edit; end

  def update
    @bank_branch.update(bank_branch_params)
    render_or_redirect_on_save 'edit'
  end

  private

  def render_or_redirect_on_save(template)
    if @bank_branch.save
      respond_to do |format|
        format.html { redirect_to staffs_administrators_bank_bank_branches_path(@bank) }
      end
    else
      render template
    end
  end

  def bank_branch_params
    params.fetch(:accounting_bank_branch).permit(:display_name, :accounting_bank_id)
  end

  def find_bank!
    @bank = Accounting::Bank.find(params[:bank_id])
  end

  def find_bank_branch!
    @bank_branch = Accounting::BankBranch.find(params[:id])
  end
end
