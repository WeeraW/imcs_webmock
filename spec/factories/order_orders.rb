FactoryGirl.define do
  factory :order_order, class: 'Order::Order' do
    sequence(:billing_id) { |n| "bill-id-#{n}" }
    paid_full_date 1.day.ago.middle_of_day
    create_by_staff nil
    paid_approve_by_staff nil
    shipping_approve_by_staff nil
  end
end
