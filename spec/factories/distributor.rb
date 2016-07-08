FactoryGirl.define do
  factory(:distributor) do
    sequence(:email) { |n| "distributor#{n}@test.com" }
    sequence(:first_name) { |n| "test#{n}"}
    sequence(:distributor_code) { |n| "d#{'0' * (9 - n.to_s.length) + n.to_s}" }
    sequence(:address) { |n| "#{n}/11 MMC Factory" }
    sequence(:city) { |n| "citytest#{n}" }
    sequence(:nickname) { |n| "Testy#{n}" }
    citizens_id '4040868013083'
    date_of_birth 18.year.ago
    distributor_referror nil
    middle_name 'T.'
    last_name 'testlastname'
    password 'test1234'
    state 'Test State'
    postal_code '12120'
  end
end
