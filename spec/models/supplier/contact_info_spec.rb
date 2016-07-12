require 'rails_helper'

RSpec.describe Supplier::ContactInfo, type: :model do
  describe '#contact_person' do
    it { should validate_length_of(:contact_person).is_at_least(2).is_at_most(120) }

    it 'should have default value = "Company" when not supply value' do
      contact_info = create(:supplier_contact_info, contact_person: nil)
      expect(contact_info.contact_person).to eq('Company')
    end

    it 'should have default value = "Company" when supply blank charactor' do
      contact_info = create(:supplier_contact_info, contact_person: " \r  \n")
      expect(contact_info.contact_person).to eq('Company')
    end
  end

  describe '#telephone_number' do
    it { should allow_value('029081205').for(:telephone_number) }
    it { should_not allow_value('02901250').for(:telephone_number) }
    it { should_not allow_value('085a45226').for(:telephone_number) }
    it { should_not allow_value('8564522691').for(:telephone_number) }
  end

  describe '#telephone_ext' do
    it { should validate_numericality_of(:telephone_ext).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe '#mobile_number' do
    it { should allow_value('0852452269').for(:mobile_number) }
    it { should_not allow_value('023456789').for(:mobile_number) }
    it { should_not allow_value('085a452269').for(:mobile_number) }
    it { should_not allow_value('08564522691').for(:mobile_number) }
  end

  describe '#fax_number' do
    it { should allow_value('029081205').for(:fax_number) }
    it { should_not allow_value('02901250').for(:fax_number) }
    it { should_not allow_value('085a45226').for(:fax_number) }
    it { should_not allow_value('8564522691').for(:fax_number) }
  end

  describe '#fax_ext' do
    it { should validate_numericality_of(:fax_ext).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'Associations' do
    describe '#supplier' do
      it { should belong_to(:supplier).class_name('Supplier::Supplier').with_foreign_key(:supplier_supplier_id) }
    end
  end
end
