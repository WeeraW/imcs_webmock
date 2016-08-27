class Product::Product < ApplicationRecord
  attr_accessor :price_th
  belongs_to :last_editor, class_name: 'Staff', foreign_key: :staff_id
  has_many :contains, class_name: 'Product::Contain', foreign_key: :product_product_id, dependent: :restrict_with_exception
  has_many :product_prices, class_name: 'Product::Price', foreign_key: :product_product_id, dependent: :restrict_with_exception

  accepts_nested_attributes_for :contains

  scope :available_products, -> { where 'saleable = TRUE' }

  before_validation :default_saleable
  before_save :generate_slug

  validates :sku,
            presence: true,
            uniqueness: { case_sensitive: false }
  validates :name_th,
            presence: true,
            length: {
              minimum: 3,
              maximum: 150
            }
  validates :description_th,
            length: {
              minimum: 0,
              maximum: 1000
            }
  validates :name_en,
            presence: true,
            length: {
              minimum: 3,
              maximum: 150
            }
  validates :description_en,
            length: {
              minimum: 0,
              maximum: 1000
            }
  validates :staff_id,
            presence: true

  def latest_price
    product_prices.last.try(:price_th).nil? ? 0 : product_prices.last.price_th
  end

  private

  def default_saleable
    self.saleable = false if saleable.nil?
  end

  def generate_slug
    self.slug = name_en.split.join('-').concat DateTime.now.strftime('%Y%m%dT%H%M%SN%3N')
  end
end
