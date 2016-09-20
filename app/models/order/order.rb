class Order::Order < ApplicationRecord
  attr_accessor :selected

  include Shippingable
  belongs_to :create_by, class_name: 'Staff', foreign_key: :create_by_staff_id
  belongs_to :paid_approve_by, class_name: 'Staff', foreign_key: :paid_approve_by_staff_id, optional: true
  belongs_to :shipping_approve_by, class_name: 'Staff', foreign_key: :shipping_approve_by_staff_id, optional: true
  belongs_to :sale_by, class_name: 'Staff', foreign_key: :sale_by_staff_id
  has_many :order_details, class_name: 'Order::Detail', foreign_key: :order_order_id
  has_many :payment_details, class_name: 'Payment::Detail', foreign_key: :order_order_id

  accepts_nested_attributes_for :payment_details
  accepts_nested_attributes_for :shipping_address

  scope :paid_full_orders, -> { where ['paid_approve_by_staff_id IS NOT ? AND shipping_approve_by_staff_id IS ?', nil, nil] }

  scope :today_orders, -> { where(created_at: DateTime.now.beginning_of_day..DateTime.now.end_of_day) }

  accepts_nested_attributes_for :order_details

  before_validation :generate_billing_id

  validates :order_details,
            presence: true

  validates :billing_id,
            presence: true,
            uniqueness: {
              case_sensitive: false
            }

  def self.fullfilled_orders_for_sale(sale_staff_id)
    where ['create_by_staff_id = ? AND shipping_approve_by_staff_id IS NOT ?', sale_staff_id, nil]
  end

  def self.shipping_approved(warehouse_staff_id)
    where shipping_approve_by_staff_id: warehouse_staff_id
  end

  def total_price
    order_details.inject(0) { |a, e| a + (e.price_per_count * e.quantity) }
  end

  def total_paid_reconciled
    payment_details.sum(:pay_amount_reconciled)
  end

  # protected
  #
  # def build_client(params)
  #   raise "Unknown client_type: #{client_type}" unless CLIENT_TYPES.include?(client_type)
  #   self.client = client_type.constantize.new(params)
  # end

  private

  def generate_billing_id
    return if persisted?
    self.billing_id = "C#{Date.today.strftime('%Y%m%d')}#{'0' * (5 - self.class.today_orders.count.to_s.length)}#{self.class.today_orders.count + 1}"
  end
end
