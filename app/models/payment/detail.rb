class Payment::Detail < ApplicationRecord
  enum status: { pending: 0, approved: 1, rejected: 2 }

  belongs_to :approve_by, class_name: 'Staff', foreign_key: :approve_by_staff_id
  belongs_to :create_by, class_name: 'Staff', foreign_key: :create_by_staff_id
  belongs_to :order, class_name: 'Order::Order', foreign_key: :order_order_id

  validates :pay_amount,
            presence: true,
            numericality: {
              greater_than_or_eqaul_to: 1,
              less_than_or_eqaul_to: 999_999_999.9999
            }
  validates :pay_datetime,
            presence: true
  validates :note,
            length: {
              maximum: 300
            }

  def reject(staff)
    return if staff.nil?
    rejected!
    self.approve_by = staff
  end

  def approve(staff)
    return if staff.nil?
    approved!
    self.approve_by = staff
  end
end
