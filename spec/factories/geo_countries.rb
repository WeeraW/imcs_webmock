FactoryGirl.define do
  factory :geo_country, class: 'Geo::Country' do
    iso_3166_a2_code "MyString"
    display_text_en "MyString"
  end
end
