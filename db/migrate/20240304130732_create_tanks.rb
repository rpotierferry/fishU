class CreateTanks < ActiveRecord::Migration[7.1]
  def change
    create_table :tanks do |t|
      t.integer :liters
      t.integer :nitrate
      t.boolean :has_lamp
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
