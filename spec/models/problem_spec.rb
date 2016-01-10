require 'rails_helper'

describe Problem, type: :model do
  let(:subject) { build(:problem) }

  it { is_expected.to belong_to(:idea) }

  it 'is valid given valid attributes' do
    expect(subject).to be_valid
  end
end
