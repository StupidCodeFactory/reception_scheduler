require "rails_helper"

RSpec.describe Scheduler do
  let(:establishment) { create :establishment }
  subject { described_class.new(establishment) }

  describe '#book' do
    let(:shift)    { double('shift', 'valid?': shift_validity) }
    let(:employee) { double('employee', 'over_capacity?': employee_over_capacity) }

    context 'when the shift is free' do
      let(:shift_validity) { true }

      context 'when the employee has not reached is working hours capacity' do
        it { expect(subject.book(shift, employee)).to be true }
      end

      context 'when the employee has not reached is working hours capacity' do
        it { expect(subject.book(shift, employee)).to be false }
      end
    end

    context 'when the shift is not free' do
      let(:shift_validity) { false }

      it { expect(subject.book(shift, employee)).to be false }
    end
  end
end
