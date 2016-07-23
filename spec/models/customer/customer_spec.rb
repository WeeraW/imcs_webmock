require 'rails_helper'

RSpec.describe Customer::Customer, type: :model do
  describe '#first_name' do
    it { should validate_presence_of(:first_name) }
    it { should validate_length_of(:first_name).is_at_least(2).is_at_most(150) }
  end

  describe '#last_name' do
    it { should validate_presence_of(:last_name) }
    it { should validate_length_of(:last_name).is_at_least(2).is_at_most(150) }
  end

  describe '#nickname' do
    it { should validate_presence_of(:nickname) }
    it { should validate_length_of(:nickname).is_at_least(2).is_at_most(30) }
  end

  describe '#telephone_number' do
    it { should allow_value('012345678').for(:telephone_number) }
    it { should_not allow_value('0123456789').for(:telephone_number) }
    it { should_not allow_value('01234567s').for(:telephone_number) }
    it { should_not allow_value('a123456789').for(:telephone_number) }
    it { should_not allow_value('012s456789').for(:telephone_number) }
  end

  describe '#mobile_number' do
    it { should allow_value('0123456789').for(:mobile_number) }
    it { should_not allow_value('a123456789').for(:mobile_number) }
    it { should_not allow_value('01234578s2').for(:mobile_number) }
    it { should_not allow_value('01234567891').for(:mobile_number) }
    it { should_not allow_value('012345678s').for(:mobile_number) }
  end

  describe 'Associations' do
    describe '#create_by' do
      it { should belong_to(:create_by).class_name('Staff').with_foreign_key(:staff_id) }
    end

    describe '#addresses' do
      it { should have_many(:addresses).class_name('Fullfillment::ShippingAddress').through(:addressable) }
    end
  end
end
