class Payment::Detail < ApplicationRecord
  enum status: { pending: 0, approved: 1, rejected: 2 }

  has_attached_file :payment_receipt_image_file
  belongs_to :approve_by, class_name: 'Staff', foreign_key: :approve_by_staff_id, optional: true
  belongs_to :create_by, class_name: 'Staff', foreign_key: :create_by_staff_id
  belongs_to :order, class_name: 'Order::Order', foreign_key: :order_order_id
  belongs_to :company_bank_account, class_name: 'Accounting::CompanyBankAccount', foreign_key: :accounting_company_bank_account_id

  validates_attachment_content_type :payment_receipt_image_file, content_type: /\Aimage/
  validates_attachment_file_name :payment_receipt_image_file, matches: [/png\Z/, /jpe?g\Z/]

  validates_attachment :payment_receipt_image_file,
                       size: { in: 1..2048.kilobytes }

  scope :pending_payments, -> { where status: :pending, approve_by: nil }

  validates :pay_amount,
            presence: true,
            numericality: {
              greater_than_or_eqaul_to: 1,
              less_than_or_eqaul_to: 999_999_999.9999
            }
  validates :pay_amount_reconciled,
            numericality: {
              greater_than_or_eqaul_to: 1,
              less_than_or_eqaul_to: 999_999_999.9999,
              allow_nil: true
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

  def self.payments_approved_by(staff)
    where status: :approved, approve_by: staff
  end
end
