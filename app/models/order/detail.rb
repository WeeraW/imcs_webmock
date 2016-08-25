class Order::Detail < ApplicationRecord
  belongs_to :order, class_name: 'Order::Order', foreign_key: :order_order_id, optional: true
  belongs_to :product, class_name: 'Product::Product', foreign_key: :product_product_id
  has_one :stock_out_history, class_name: 'Inventory::OrderStockOutHistory', foreign_key: :order_detail_id
  has_many :item_lot_stock_outs, class_name: 'Inventory::ItemLotStockOut', through: :stock_out_history

  before_validation :set_price_percount

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
  private

  def set_price_percount
    self.price_per_count = product.latest_price
  end
end
