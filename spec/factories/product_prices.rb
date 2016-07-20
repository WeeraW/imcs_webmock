FactoryGirl.define do
  factory :product_price, class: 'Product::Price' do
    price_th 10.0000
    association :product, factory: :product_product
    association :create_by, factory: :staff
  end
end
