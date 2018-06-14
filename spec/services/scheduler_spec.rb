require "rails_helper"

RSpec.describe Scheduler do
  let(:establishment) { create :establishment }
  subject { described_class.new(establishment) }

  describe '#book' do

    let(:shift)    { double('shift', 'valid?': shift_validity, duration: shift_duration) }
    let(:shift_duration) { 6.hours }

    let(:employee) { double('employee', total_time_worked: total_time_worked) }
    let(:total_time_worked) { 0.hours }

    context 'when the shift is free' do
      let(:shift_validity) { true }

      context 'when the employee has not reached is working hours capacity' do
        it { expect(subject.book(employee, shift)).to be true }
      end

      context 'when the employee has not reached is working hours capacity' do
        let(:total_time_worked) { 40.hours }

        it { expect(subject.book(employee, shift)).to be false }
      end
    end

    context 'when the shift is not free' do
      let(:shift_validity) { false }

      it { expect(subject.book(employee, shift)).to be false }
    end
  end
end
