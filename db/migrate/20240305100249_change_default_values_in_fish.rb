class ChangeDefaultValuesInFish < ActiveRecord::Migration[7.1]
  def change
    change_column_default :fish, :size, 1
    change_column_default :fish, :sick, false
    change_column_default :fish, :alive, true
  end
end
