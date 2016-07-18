require 'rails_helper'

RSpec.describe Warehouse::FacilityType, type: :model do
  describe '#code' do
    it { should validate_presence_of(:code) }
    it 'should validate uniqueness case insensitive' do
      record = create :warehouse_facility_type, code: 'TEST'
      expect { create(:warehouse_facility_type, code: record.code.downcase) }.to raise_error(ActiveRecord::RecordInvalid, /in use|taken/i)
    end
    it { should validate_length_of(:code).is_at_least(2).is_at_most(30) }
    it { should allow_value('ads123').for(:code) }
    it { should allow_value('ASD123').for(:code) }
    it { should allow_value('ASD123asd').for(:code) }
    it { should allow_value('ads_123ASD').for(:code) }
    it { should allow_value('12ASD_123').for(:code) }
    it { should_not allow_value('กก').for(:code) }
    it { should_not allow_value('กก123').for(:code) }
    it { should_not allow_value('กก.123').for(:code) }
    it { should_not allow_value('ads123กก').for(:code) }
    it { should_not allow_value('.หก').for(:code) }
    it { should_not allow_value('122ฟกasd').for(:code) }
  end

  describe '#display_name' do
    it { should validate_presence_of(:display_name) }
    it 'should validate uniqueness case insensitive' do
      record = create :warehouse_facility_type, display_name: 'TEST HOLA'
      expect { create(:warehouse_facility_type, display_name: record.display_name.downcase) }.to raise_error(ActiveRecord::RecordInvalid, /in use|taken/i)
    end
  end

  describe 'Associations' do
    describe '#warehouse_facilities' do
      it { should have_many(:warehouse_facilities) }
    end
  end
end
