class AddAttachmentPaymentReceiptImageFileToPaymentDetails < ActiveRecord::Migration[5.0]
  def self.up
    change_table :payment_details do |t|
      t.attachment :payment_receipt_image_file
    end
  end

  def self.down
    remove_attachment :payment_details, :payment_receipt_image_file
  end
end
