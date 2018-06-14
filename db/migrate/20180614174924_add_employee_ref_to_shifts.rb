class AddEmployeeRefToShifts < ActiveRecord::Migration[5.2]
  def change
    add_reference :shifts, :employee, foreign_key: true
  end
end
