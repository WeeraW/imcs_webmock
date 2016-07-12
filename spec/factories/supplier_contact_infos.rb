FactoryGirl.define do
  factory :supplier_contact_info, class: 'Supplier::ContactInfo' do
    sequence(:contact_person) { |n| "Contact Person #{n}" }
    sequence(:telephone_number) { |n| '0' * (9 - n.to_s.length) + n.to_s }
    sequence(:telephone_ext) { |n| n.to_s }
    sequence(:mobile_number) { |n| '0' * (10 - n.to_s.length) + n.to_s }
    sequence(:fax_number) { |n| '0' * (9 - n.to_s.length) + n.to_s }
    sequence(:fax_ext) { |n| n.to_s }
    supplier nil
  end
end
