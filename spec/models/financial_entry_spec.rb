require 'rails_helper'

describe FinancialEntry, type: :model do
  let(:subject) { build(:financial_entry) }

  it { is_expected.to belong_to(:idea) }
  it { is_expected.to have_one(:user).through(:idea) }

  it 'is valid given valid attributes' do
    expect(subject).to be_valid
  end

  context '#name' do
    it { is_expected.to validate_presence_of(:name) }
  end

  context '#value' do
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_numericality_of(:value).is_greater_than_or_equal_to(0) }

    it 'rounds to 2 decimal places' do
      subject.value = 123.123
      expect(subject.value).to eq(123.12)
    end
  end
end
