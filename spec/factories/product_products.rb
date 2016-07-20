FactoryGirl.define do
  factory :product_product, class: 'Product::Product' do
    sequence(:sku) { |n| "SKU-TEST-#{n}" }
    sequence(:name_th) { |n| "สินค้าที่ #{n}" }
    sequence(:description_th) { |n| "รายละเอียดทดสอบ #{n}" }
    sequence(:name_en) { |n| "Product #{n}" }
    sequence(:description_en) { |n| "Product describtion #{n}" }
    sequence(:slug) { |n| "slug-test-#{n}" }
    association :last_editor, factory: :staff
    saleable nil
    product_prices []
  end
end
