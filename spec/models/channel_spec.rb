require 'rails_helper'

describe Channel, type: :model do
  let(:subject) { build(:channel) }

  it { is_expected.to have_and_belong_to_many(:ideas) }

  it 'is valid given valid attributes' do
    expect(subject).to be_valid
  end

  context '#name' do
    it { is_expected.to validate_presence_of(:name) }

    it 'rejects duplicates' do
      create(:channel)
      expect(Channel.new).to validate_uniqueness_of(:name)
    end
  end

end
