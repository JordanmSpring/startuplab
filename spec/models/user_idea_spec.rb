require 'rails_helper'

describe UserIdea, type: :model do
  let(:subject) { build(:user_idea) }

  it { is_expected.to belong_to(:shared_user) }
  it { is_expected.to belong_to(:shared_idea) }

  it 'is valid given valid attributes' do
    expect(subject).to be_valid
  end

  context '#access_level' do
    it { is_expected.to validate_presence_of(:access_level) }
    it { is_expected.to validate_inclusion_of(:access_level).in_array(UserIdea::ACCESS_LEVELS) }
  end
end
