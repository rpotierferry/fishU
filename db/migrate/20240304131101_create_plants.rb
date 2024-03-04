class CreatePlants < ActiveRecord::Migration[7.1]
  def change
    create_table :plants do |t|
      t.references :tank, null: false, foreign_key: true
      t.string :plant_type
      t.integer :life_expectancy

      t.timestamps
    end
  end
end
