class Product::Price < ApplicationRecord
  belongs_to :product, class_name: 'Product::Product', foreign_key: :product_product_id, optional: true
  belongs_to :create_by, class_name: 'Staff', foreign_key: :staff_id

  validates :price_th,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 0.0000,
              less_than_or_equal_to: 999_999.9999
            }
end
