require 'rails_helper'

RSpec.describe Distributor, :type => :model do
  describe '#citizens_id' do
    subject { create(:distributor) }
    it { should validate_presence_of(:citizens_id) }
    it { should validate_uniqueness_of(:citizens_id).case_insensitive }
    # it { should validate_length_of(:citizens_id).is_equal_to(10) }
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

  describe '#generate_distributetor_code' do
  end

  describe '#thai_citizens_id_checksum' do
  end

  describe '#thai_citizens_id_to_parity_and_array_digits' do
  end

  describe '#thai_convert_to_pairs_coefficient_and_digit' do
  end

  describe '#thai_citizens_id_digits_sum' do
  end
end
