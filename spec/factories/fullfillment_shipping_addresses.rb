FactoryGirl.define do
  factory :fullfillment_shipping_address, class: 'Fullfillment::ShippingAddress' do
    sequence(:recipient_name) { |n| "Recipient Test#{n}" }
    recipient_telephone_number "0123456789"
    sequence(:address) { |n| "#{n}/14 MMC Factory" }
    sequence(:district) { |n| "District #{n}" }
    sequence(:city) { |n| "City #{n}" }
    sequence(:state) { |n| "State Test#{n}" }
    postal_code '12345'
  end
end
