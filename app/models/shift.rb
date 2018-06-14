class Shift < ApplicationRecord

  MAX_HOURS_A_DAY = 8.hours.to_i

  belongs_to :establishment
  belongs_to :employee

  validates_presence_of :slot
  validate :no_overlapping_shift
  validate :does_not_exceed_eight_hours

  scope :overlapping, -> (slot) { where('(lower(slot), upper(slot)) OVERLAPS (?::timestamp, ?::timestamp)', slot.begin, slot.end) }
  def duration
    return if slot.nil?
    (slot.end - slot.begin).round
  end

  private

  def no_overlapping_shift
    return unless slot
    return unless establishment.shifts.overlapping(slot).count > 0
    errors.add(:slot, 'has already been alocated')
  end

  def does_not_exceed_eight_hours
    return unless slot
    if duration > MAX_HOURS_A_DAY
      errors.add(:slot, 'can not alocate slot greater than 8 hours')
    end
  end
end
