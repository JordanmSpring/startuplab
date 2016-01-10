require 'rails_helper'

describe Vote, type: :model do
  let(:subject) { build(:vote) }

  it { is_expected.to belong_to(:voteable) }
  it { is_expected.to belong_to(:voter) }

  it 'is valid given valid attributes' do
    expect(subject).to be_valid
  end

  context '#voteable_id' do
    it { is_expected.to validate_presence_of(:voteable_id) }

    it 'rejects duplicates' do
      create(:vote)
      expect(Vote.new).to validate_uniqueness_of(:voteable_id).case_insensitive.scoped_to(:voteable_type, :voter_type, :voter_id)
    end
  end
end
