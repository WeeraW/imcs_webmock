require 'rails_helper'

RSpec.describe Order::Order, type: :model do
  describe '#billing_id' do
    it { should validate_presence_of(:billing_id) }
    it { should validate_uniqueness_of(:billing_id).case_insensitive }
  end

  describe '#paid_full_date' do
    pending 'Nothing todo yet.'
  end

  describe 'Associations' do
    describe '#create_by' do
      it { should validate_presence_of(:create_by_staff_id).on(:create) }
      it { should belong_to(:create_by).class_name('Staff').with_foreign_key(:create_by_staff_id) }
    end
    describe '#paid_approve_by' do
      it { should belong_to(:paid_approve_by).class_name('Staff').with_foreign_key(:paid_approve_by_staff_id) }
    end

    describe '#shipping_approve_by' do
      it { should belong_to(:shipping_approve_by).class_name('Staff').with_foreign_key(:shipping_approve_by_staff_id) }
    end
  end
end
