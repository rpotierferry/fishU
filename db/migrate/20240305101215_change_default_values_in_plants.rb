class ChangeDefaultValuesInPlants < ActiveRecord::Migration[7.1]
  def change
    change_column_default :plants, :life_expectancy, 2
  end
end
