class Order::Order < ApplicationRecord
  belongs_to :create_by, class_name: 'Staff', foreign_key: :create_by_staff_id
  belongs_to :paid_approve_by, class_name: 'Staff', foreign_key: :paid_approve_by_staff_id
  belongs_to :shipping_approve_by, class_name: 'Staff', foreign_key: :shipping_approve_by_staff_id

  validates :billing_id,
            presence: true,
            uniqueness: {
              case_sensitive: false
            }
  validates :create_by_staff_id,
            presence: :create_by_staff_id,
            on: :create
end
