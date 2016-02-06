require 'rails_helper'

describe UserIdea, type: :model do
  let(:subject) { build(:user_idea) }

  it { is_expected.to belong_to(:shared_user) }
  it { is_expected.to belong_to(:shared_idea) }

  it 'is valid given valid attributes' do
    expect(subject).to be_valid
  end

  context '#shared_user' do
    it { is_expected.to validate_presence_of(:shared_user) }
  end

  context '#shared_idea' do
    it { is_expected.to validate_presence_of(:shared_idea) }
  end

  context '#user_id' do
    it { is_expected.to validate_presence_of(:user_id) }

    it 'rejects duplicates' do
      create(:user_idea)
      expect(UserIdea.new).to validate_uniqueness_of(:user_id).scoped_to(:idea_id)
    end
  end

  context '#access_level' do
    it { is_expected.to validate_presence_of(:access_level) }
    it { is_expected.to validate_inclusion_of(:access_level).in_array(UserIdea::ACCESS_LEVELS) }
  end
end
