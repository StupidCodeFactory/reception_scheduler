class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :employees, :name, unique: true
  end
end
