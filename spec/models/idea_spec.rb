require 'rails_helper'

describe Idea, type: :model do
  let(:subject) { build(:idea) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:problems) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:founders) }
  it { is_expected.to have_many(:financial_entries) }
  it { is_expected.to have_many(:user_ideas) }
  it { is_expected.to have_many(:users).through(:founders) }
  it { is_expected.to have_many(:shared_users).through(:user_ideas) }
  it { is_expected.to have_and_belong_to_many(:channels) }
  it { is_expected.to have_and_belong_to_many(:crowdfunding_options) }

  it 'is valid given valid attributes' do
    expect(subject).to be_valid
  end

  context '#name' do
    it { is_expected.to validate_presence_of(:name) }
  end

  context '#publish!' do
    it 'publishes the idea' do
      expect(subject).not_to be_published
      subject.publish!
      expect(subject).to be_published
    end
  end

  context '#unpublish!' do
    it 'publishes the idea' do
      subject.published = true
      expect(subject).to be_published
      subject.unpublish!
      expect(subject).not_to be_published
    end
  end

  context '#owner?' do
    it 'returns true if the given user is the owner' do
      expect(subject.owner?(subject.user)).to be true
    end

    it 'returns false if the given user is not the owner' do
      expect(subject.owner?(create(:user))).to be false
    end
  end

  context '#founder?' do
    it 'returns true if the given user is a founder' do
      subject.users << subject.user
      expect(subject.founder?(subject.user)).to be true
    end

    it 'returns false if the given user is not a founder' do
      expect(subject.founder?(create(:user))).to be false
    end
  end

end
