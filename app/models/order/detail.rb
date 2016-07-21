class Order::Detail < ApplicationRecord
  belongs_to :order, class_name: 'Order::Order', foreign_key: :order_order_id
  belongs_to :product, class_name: 'Product::Product', foreign_key: :product_product_id

  validates :price_per_count,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 0,
              less_than_or_equal_to: 999_999_999.9999
            }
  validates :quantity,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 999
            }
  validates :order_order_id,
            presence: true
  validates :product_product_id,
            presence: true
end
