FactoryGirl.define do
  factory :fullfillment_act_as_shippingable, class: 'Fullfillment::ActAsShippingable' do
    association :fullfillment_shipping_address, factory: :fullfillment_shipping_address
  end
end
