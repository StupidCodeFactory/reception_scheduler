class Add < ActiveRecord::Migration[5.2]
  def change
    add_reference :shifts, :establishment, foreign_key: true
  end
end
