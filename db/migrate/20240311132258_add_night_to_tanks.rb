class AddNightToTanks < ActiveRecord::Migration[7.1]
  def change
    add_column :tanks, :night, :boolean, default: false
  end
end
