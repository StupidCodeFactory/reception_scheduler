class Employee < ApplicationRecord
  has_many :shifts

  def weekly_worked_hours_count
    shifts.where('lower(slot) > ?', Time.zone.now.beginning_of_week).map(&:duration).sum
  end
end
