require 'rails_helper'

RSpec.describe Fullfillment::ShippingAddress, type: :model do
  describe '#recipient_name' do
    it { should validate_presence_of(:recipient_name) }
    it { should validate_length_of(:recipient_name).is_at_least(4).is_at_most(150) }
  end

  describe '#recipient_telephone_number' do
    it { should validate_length_of(:recipient_telephone_number).is_at_least(9) }
    it { should validate_numericality_of(:recipient_telephone_number).only_integer }
  end

  describe '#address' do
    it { should validate_presence_of(:address) }
    it { should validate_length_of(:address).is_at_least(3).is_at_most(500) }
  end

  describe '#district' do
    it { should validate_presence_of(:district) }
    it { should validate_length_of(:district).is_at_least(3).is_at_most(150) }
  end

  describe '#city' do
    it { should validate_presence_of(:city) }
    it { should validate_length_of(:city).is_at_least(3).is_at_most(150) }
  end

  describe '#state' do
    it { should validate_presence_of(:state) }
    it { should validate_length_of(:state).is_at_least(3).is_at_most(150) }
  end

  describe '#postal_code' do
    it { should validate_presence_of(:postal_code) }
    it { should validate_length_of(:postal_code).is_equal_to(5) }
  end
  describe 'Associations' do
    describe '#act_as_shippingables' do
      it { should have_many(:act_as_shippingables).class_name('Fullfillment::ActAsShippingable') }
    end

    describe '#ship_by_orders' do
      it { should have_many(:ship_by_orders).class_name('Order::Order').through(:act_as_shippingables).dependent(:restrict_with_exception) }
    end
  end
end
