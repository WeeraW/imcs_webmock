require 'rails_helper'

RSpec.describe Fullfillment::ActAsShippingable, type: :model do
  describe 'Associations' do
    describe '#fullfillment_shipping_address' do
      it { should belong_to(:fullfillment_shipping_address).class_name('Fullfillment::ShippingAddress').with_foreign_key(:fullfillment_shipping_address_id) }
    end

    describe '#shippingable' do
      it { should belong_to(:shippingable) }
    end
  end
end
