class ChangeDefaultValuesInTanks < ActiveRecord::Migration[7.1]
  def change
    change_column_default :tanks, :liters, 5
    change_column_default :tanks, :nitrate, 0
    change_column_default :tanks, :has_lamp, false
  end
end
