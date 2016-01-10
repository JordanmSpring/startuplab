require 'rails_helper'

describe CrowdfundingOption, type: :model do
  let(:subject) { build(:crowdfunding_option) }

  it 'is valid given valid attributes' do
    expect(subject).to be_valid
  end

  context '#name' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
