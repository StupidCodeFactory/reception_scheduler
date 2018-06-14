class Shift < ApplicationRecord
  belongs_to :establishment
  belongs_to :employee

  validates_presence_of :slot

  def duration
    return if slot.nil?
    (slot.end - slot.begin).round
  end

end
