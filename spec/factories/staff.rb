FactoryGirl.define do
  factory(:staff) do
    sequence(:email) { |n| "distributor#{n}@test.com" }
    sequence(:first_name) { |n| "test#{n}" }
    sequence(:staff_account) { |n| "staff#{n}" }
    last_name 'testlastname'
    password 'test1234'
  end
end
