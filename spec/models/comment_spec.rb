require 'rails_helper'

describe Comment, type: :model do
  let(:subject) { build(:comment) }

  it { is_expected.to belong_to(:idea) }
  it { is_expected.to belong_to(:user) }

  it 'is valid given valid attributes' do
    expect(subject).to be_valid
  end

  context '#body' do
    it { is_expected.to validate_presence_of(:body) }
  end

  context '#status' do
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_inclusion_of(:status).in_array(Comment::STATUSES) }
  end
end
