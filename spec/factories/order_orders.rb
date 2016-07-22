FactoryGirl.define do
  factory :order_order, class: 'Order::Order' do
    sequence(:billing_id) { |n| "bill-id-#{n}" }
    paid_full_date 1.day.ago.middle_of_day
    association :create_by, factory: :staff
    association :paid_approve_by, factory: :staff
    association :shipping_approve_by, factory: :staff
  end
end
