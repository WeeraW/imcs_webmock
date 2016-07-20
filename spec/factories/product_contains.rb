FactoryGirl.define do
  factory :product_contain, class: 'Product::Contain' do
    association :inventoy_inventory_item, factory: :inventoy_inventory_item
    association :product_product, factory: :product_product
    quantity 10
  end
end
