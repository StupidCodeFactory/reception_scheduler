require 'rails_helper'

RSpec.describe Shift, type: :model do
  subject { build :shift, establishment: create(:establishment), employee: create(:employee) }

  it { is_expected.to belong_to(:establishment) }
  it { is_expected.to belong_to(:employee) }

  describe 'validation' do

    it { is_expected.to validate_presence_of(:slot) }

    describe '#does_not_exceed_eight_hours' do
      let(:nowish) { Time.zone.now }
      before do
        expect(subject).to be_valid
        subject.slot = nowish..(nowish + 8.hours + 1.minute)
      end

      it { is_expected.to be_invalid }
    end
  end

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
