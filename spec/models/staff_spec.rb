require 'rails_helper'

RSpec.describe Staff, :type => :model do
  describe '#first_name' do
    it { should validate_presence_of(:first_name) }
  end

  describe '#last_name' do
    it { should validate_presence_of(:last_name) }
  end

  describe '#staff_account' do
    it { should validate_presence_of(:staff_account) }
    it 'should validate uniqueness of staff_account case insensitive' do
      staff = create :staff
      expect { create(:staff, staff_account: staff.staff_account) }.to raise_error(ActiveRecord::RecordInvalid, /(in use|taken)/i)
    end
  end

  describe '#email' do
    it 'should validate uniqueness of email case insensitive' do
      staff = create :staff
      expect { create(:staff, email: staff.email) }.to raise_error(ActiveRecord::RecordInvalid, /(in use|taken)/i)
    end
  end

  describe '#employee_code' do
    it { should validate_presence_of(:employee_code) }

    it 'should validate uniqueness of employee_code case insensitive' do
      staff = create :staff
      expect { create(:staff, employee_code: staff.employee_code) }.to raise_error(ActiveRecord::RecordInvalid, /(in use|taken)/i)
    end
  end

  describe '#Association' do
    describe '#created_distributors' do
      let(:staff_creator) { create :staff }

      it 'should have a saff who create distributor' do
        distributor = create :distributor, staff_creator: staff_creator
        expect(distributor.staff_creator).to eq(staff_creator)
      end

      it 'should has many distributors' do
        create(:distributor, citizens_id: '7831843207010', distributor_code: 'd000000001', staff_creator: staff_creator)
        create(:distributor, citizens_id: '4108613044478', distributor_code: 'd000000002', staff_creator: staff_creator)
        expect(staff_creator.created_distributors.count).to eq(2)
      end
    end
  end
end
