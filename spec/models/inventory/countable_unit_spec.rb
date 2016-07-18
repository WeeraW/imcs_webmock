require 'rails_helper'

RSpec.describe Inventory::CountableUnit, type: :model do
  describe 'Associations' do
    describe '#act_as_countables' do
      it { should have_many(:act_as_countables) }
    end
  end
end
