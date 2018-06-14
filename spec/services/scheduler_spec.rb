require "rails_helper"

RSpec.describe Scheduler do
  let(:establishment) { create :establishment }
  subject { described_class.new(establishment) }

  describe '#book' do
    let(:shift_start) { Time.zone.now }
    let(:shift_end)   { shift_start + 7.hours }
    let(:shift)       { build(:shift, slot: shift_start..shift_end) }

    let(:employee) { create(:employee) }

    let(:total_time_worked) { 0.hours }

    context 'when the shift is free' do
      let(:shift_validity) { true }

      context 'when the employee has not reached is working hours capacity' do
        it { expect(subject.book(employee, shift)).to be true }
      end

      context 'when the employee has not reached is working hours capacity' do
        before do
          %i[ monday tuesday wednesday thursday friday ].each do |day|
            create(:shift, day, employee: employee, establishment: establishment)
          end
        end

        it { expect(subject.book(employee, shift)).to be false }
      end
    end

    context 'when the shift is not free' do
      let(:shift_validity) { false }
      before do
        create(:shift, slot: shift_start..shift_end, employee: employee, establishment: establishment)
      end

      it { expect { subject.book(employee, shift).to_not change { Shift.count } } }

      context 'has an error message' do
        before do
          subject.book(employee, shift)
        end

        it { expect(shift.errors.full_messages_for(:slot)).to eq(['Slot has already been alocated']) }
      end
    end
  end
end
