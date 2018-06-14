require 'rails_helper'

RSpec.describe Shift, type: :model do
  it { is_expected.to belong_to(:establishment) }
  it { is_expected.to belong_to(:employee) }

  it { is_expected.to validate_presence_of(:slot) }

  describe '#duration' do
    let(:shift_start) { Time.zone.now }
    let(:shift_end)   { shift_start + 7.hours }

    before do
      subject.slot = shift_start..shift_end
    end
    describe 'when #slot is not null' do
      it { expect(subject.duration).to eq(7.hours)  }
    end
  end
end
