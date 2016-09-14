class Staffs::Administrators::FreightProvidersController < ApplicationController
  before_action :authenticate_staff!
  before_action :find_freight_provider!, only: [:edit, :update]
  def index
    @freight_providers = Freight::Provider.where(['id <> ?', 0]).page(params[:page]).per(params[:per_page])
  end

  def new
    @freight_provider = Freight::Provider.new
  end

  def create
    @freight_provider = Freight::Provider.new(freight_provider_params)
    render_or_redirect_on_save 'new'
  end

  def edit; end

  def update
    @freight_provider.update(freight_provider_params)
    render_or_redirect_on_save 'edit'
  end

  private

  def find_freight_provider!
    @freight_provider = Freight::Provider.find(params[:id])
  end

  def render_or_redirect_on_save(template)
    if @freight_provider.save
      respond_to do |format|
        format.html { redirect_to staffs_administrators_freight_providers_path }
      end
    else
      render template
    end
  end

  def freight_provider_params
    params.fetch(:freight_provider).permit(:name, :telephone_number, :fax_number)
  end
end
