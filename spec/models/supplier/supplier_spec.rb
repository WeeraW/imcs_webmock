require 'rails_helper'

RSpec.describe Supplier::Supplier, type: :model do
  describe '#company_code' do
    it { should validate_presence_of(:company_code) }
    it { should validate_length_of(:company_code).is_at_least(2).is_at_most(150) }
    it { should validate_uniqueness_of(:company_code).case_insensitive }
  end

  describe '#tax_id' do
    it { should validate_length_of(:tax_id).is_equal_to(13) }
    it { should validate_uniqueness_of(:tax_id).case_insensitive }
  end

  describe '#address' do
    it { should validate_length_of(:address).is_at_least(0).is_at_most(500) }
  end

  describe '#postal_code' do
    it { should validate_length_of(:postal_code).is_equal_to(5) }
  end

  describe '#display_name' do
    it { should validate_presence_of(:display_name) }
    it { should validate_length_of(:display_name).is_at_least(2).is_at_most(150) }
  end

  describe 'Associations' do
    describe '#contact_infos' do
      it { should have_many(:contact_infos).dependent(:restrict_with_exception) }
    end
  end
end
