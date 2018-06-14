class Scheduler

  MAX_WORKING_HOURS = 40.hours.to_i

  def initialize(establishment)
    self.establishment = establishment
  end

  def book(employee, shift)
    shift.assign_attributes(employee: employee, establishment: establishment)

    return false unless shift.valid?
    return false if employee_would_be_over_capacity?(employee, shift)

    shift.save
  end

  private
  attr_accessor :establishment

  def employee_would_be_over_capacity?(employee, shift)
    (shift.duration + employee.weekly_worked_hours_count) > MAX_WORKING_HOURS
  end
end
