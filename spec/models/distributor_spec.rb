require 'rails_helper'

RSpec.describe Distributor, :type => :model do
  describe '#citizens_id' do
    subject { create(:distributor) }
    it { should validate_presence_of(:citizens_id) }
    it { should validate_uniqueness_of(:citizens_id).case_insensitive }
    it { should validate_length_of(:citizens_id).is_equal_to(13) }
  end

  describe '#first_name' do
    it { should validate_presence_of(:first_name) }
    it { should validate_length_of(:first_name).is_at_least(1).is_at_most(150) }
  end

  describe '#last_name' do
    it { should validate_presence_of(:last_name) }
    it { should validate_length_of(:last_name).is_at_least(1).is_at_most(150) }
  end

  describe '#date_of_birth' do
    it { should validate_presence_of(:date_of_birth) }
  end

  describe '#distributor_code' do
    it { should validate_presence_of(:distributor_code) }
    it { should validate_length_of(:distributor_code).is_equal_to(10) }
  end

  describe '#validate_thai_citizens_id' do
    it 'SHOULD valid' do
      record = create(:distributor, citizens_id: '1559900188261')
      expect(record).to be_valid
    end

    context 'WHEN Thai Citizens ID Wrong Checksum' do
      let(:record) { build(:distributor, citizens_id: '1559900188262') }
      context 'SHOULD' do
        it 'invalid' do
          expect(record.valid?).to be false
        end

        it 'contain error message' do
          record.valid?
          expect(record.errors.full_messages).to include('Citizens ID is invalid')
        end
      end
    end
  end

  describe '#generate_distributor_code' do
    pending 'Nothing todo right now YaY!'
  end

  describe '#distributor_sponsor_at_depth' do
    pending 'Not implemented yet.'
  end

  describe '#Asscociation' do
    describe '#distributor_referrees' do
      context 'referree at level 1' do
        let(:staff_creator) { build :staff }
        let(:top_parent) { create(:distributor, citizens_id: '4040868013083', distributor_referror: nil, staff_creator: staff_creator) }
        it 'should have parent distributor' do
          child_l1_1 = create(:distributor, citizens_id: '7831843207010', distributor_code: 'd000000001', distributor_referror: top_parent)
          expect(child_l1_1.distributor_referror.id).to eq(top_parent.id)
        end

        it 'should have many child distributor' do
          create(:distributor, citizens_id: '7831843207010', distributor_code: 'd000000001', distributor_referror: top_parent)
          create(:distributor, citizens_id: '4108613044478', distributor_code: 'd000000002', distributor_referror: top_parent)
          create(:distributor, citizens_id: '8027852718511', distributor_code: 'd000000003', distributor_referror: top_parent)
          create(:distributor, citizens_id: '7612785074141', distributor_code: 'd000000004', distributor_referror: top_parent)
          create(:distributor, citizens_id: '3263463488232', distributor_code: 'd000000005', distributor_referror: top_parent)
          expect(top_parent.distributor_referrees.count).to eq(5)
        end
      end
    end

    describe '#staff' do
      it { should belong_to :staff_creator }
    end
  end
end
