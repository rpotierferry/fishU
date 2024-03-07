class CreateTanks < ActiveRecord::Migration[7.1]
  def change
    create_table :tanks do |t|
      t.integer :liters, default: 5
      t.integer :nitrate, default: 0
      t.boolean :has_lamp, default: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
