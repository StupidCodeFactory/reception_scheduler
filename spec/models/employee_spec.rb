require 'rails_helper'

RSpec.describe Employee, type: :model do
  let(:establishment) { create :establishment }
  subject { create :employee }

  it { is_expected.to have_many(:shifts) }

  describe '#weekly_worked_hours_count' do
    let(:old_shift_start)   { Time.zone.now.beginning_of_week - 3.hours }
    let!(:old_shift)        do
      create(:shift,
             slot: old_shift_start..(old_shift_start + 3.hours),
             employee: subject,
             establishment: establishment)
    end

    let!(:weekly_shift_one) do
      create(:shift,
             slot: 7.hours.ago..Time.zone.now,
             employee: subject,
             establishment: establishment
            )
    end
    let!(:weekly_shift_two) do
      create(:shift,
             slot: 3.hours.ago..Time.zone.now,
             employee: subject,
             establishment: establishment)
    end
    before do
      subject.reload
    end

    it { expect(subject.weekly_worked_hours_count).to eq(10.hours.to_i) }
  end
end
