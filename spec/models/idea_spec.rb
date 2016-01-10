require 'rails_helper'

describe Idea, type: :model do
  let(:subject) { build(:idea) }

  it 'is valid given valid attributes' do
    expect(subject).to be_valid
  end

end
