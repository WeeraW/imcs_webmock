FactoryGirl.define do
  factory :order_detail, class: 'Order::Detail' do
    order nil
    product_product nil
    quantity 1
    price_per_count 10.00
  end
end
