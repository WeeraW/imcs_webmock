require 'rails_helper'

RSpec.describe Payment::Detail, type: :model do
  describe '#approve' do
    before(:each) do
      @staff_record = create :staff
      @payment_details_record = create :payment_detail
      @payment_details_record.approve(@staff_record)
    end
    it 'should have :status equal "approved"' do
      expect(@payment_details_record.status).to eq('approved')
    end
    it 'should have :approve_by staff' do
      expect(@payment_details_record.approve_by).to eq(@staff_record)
    end
  end

  describe '#reject' do
    before(:each) do
      @staff_record = create :staff
      @payment_details_record = create :payment_detail
      @payment_details_record.reject(@staff_record)
    end
    it 'should have :status equal "rejected"' do
      expect(@payment_details_record.status).to eq('rejected')
    end
  end

  describe '#status' do
    context 'when create new :payment_detail' do
      it 'should have initial :status equal "pending"' do
        payment_details_record = create :payment_detail
        expect(payment_details_record.status).to eq('pending')
      end
    end
  end

  describe '#pay_amount' do
    it { should validate_presence_of(:pay_amount).on(:create) }
    it { validate_numericality_of(:pay_amount).is_greater_than_or_equal_to(1).is_less_than_or_equal_to(999_999_999.9999) }
  end

  describe '#pay_datetime' do
    it { should validate_presence_of(:pay_datetime).on(:create) }
  end

  describe '#note' do
    it { should validate_length_of(:note).is_at_most(300) }
  end

  describe 'Associations' do
    describe '#order' do
      it { should belong_to(:order).class_name('Order::Order').with_foreign_key(:order_order_id) }
    end

    describe '#approve_by' do
      it { should belong_to(:approve_by).class_name('Staff').with_foreign_key(:approve_by_staff_id) }
    end

    describe '#create_by' do
      it { should belong_to(:create_by).class_name('Staff').with_foreign_key(:create_by_staff_id) }
    end
  end
end
