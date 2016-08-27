FactoryGirl.define do
  factory :payment_detail, class: 'Payment::Detail' do
    pay_amount 10
    pay_datetime 1.day.ago.at_noon
    note 'Test note'
    association :order, factory: :order_order
    association :approve_by, factory: :staff
    association :create_by, factory: :staff
  end
end
