class CreateFish < ActiveRecord::Migration[7.1]
  def change
    create_table :fish do |t|
      t.string :name
      t.boolean :sick
      t.boolean :alive
      t.references :tank, null: false, foreign_key: true
      t.string :species
      t.integer :size

      t.timestamps
    end
  end
end
