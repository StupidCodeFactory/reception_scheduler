class Scheduler

  MAX_WORKING_HOURS = 40.hours.freeze

  def initialize(establishment)
    self.establishment = establishment
  end

  def book(employee, shift)
    return false unless shift.valid?
    return false if employee_would_be_over_capacity?(employee, shift)

    establishment.shifts.create(employee: employee)
  end

  private
  attr_accessor :establishment

  def employee_would_be_over_capacity?(employee, shift)
    (shift.duration + employee.total_time_worked) > MAX_WORKING_HOURS
  end
end
