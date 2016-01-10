require 'rails_helper'

describe User, type: :model do
  let(:subject) { build(:user) }

  it { is_expected.to have_many(:ideas) }
  it { is_expected.to have_many(:comments) }
  it { is_expected.to have_many(:founders) }
  it { is_expected.to have_many(:user_ideas) }
  it { is_expected.to have_many(:shared_ideas).through(:user_ideas) }

  it 'is valid given valid attributes' do
    expect(subject).to be_valid
  end

  context '#role' do
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to validate_inclusion_of(:role).in_array(User::ROLES) }
  end

  context '#pending?' do
    it 'returns false if this user was not invited' do
      subject.invitation_created_at = nil
      expect(subject).not_to be_pending
    end

    it 'returns true if this user was invited but never accepted' do
      subject.invitation_created_at  = Time.now
      subject.invitation_accepted_at = nil
      expect(subject).to be_pending
    end

    it 'returns false if this user was invited and then accepted' do
      subject.invitation_created_at  = Time.now
      subject.invitation_accepted_at = Time.now
      expect(subject).not_to be_pending
    end
  end

  context '#admin?' do
    it 'returns true for admin users' do
      subject.role = User::ROLE_ADMIN
      expect(subject).to be_admin
    end

    it 'returns false for non-admin users' do
      subject.role = User::ROLE_USER
      expect(subject).not_to be_admin
    end
  end
end
