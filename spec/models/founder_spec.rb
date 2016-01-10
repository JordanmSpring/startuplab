require 'rails_helper'

describe Founder, type: :model do
  let(:subject) { build(:founder) }

  it { is_expected.to belong_to(:idea) }
  it { is_expected.to belong_to(:user) }

  it 'is valid given valid attributes' do
    expect(subject).to be_valid
  end

  context '#pending' do
    it 'is not pending if the user is present' do
      subject.user = build(:user, invitation_created_at: Time.now, invitation_accepted_at: Time.now)
      expect(subject.pending?).to be false
    end

    it 'is pending if the user is blank' do
      subject.user = nil
      expect(subject.pending?).to be true
    end

    it 'is pending if the user has not accepted the invitation' do
      subject.user = build(:user, invitation_created_at: Time.now)
      expect(subject.pending?).to be true
    end
  end
end
