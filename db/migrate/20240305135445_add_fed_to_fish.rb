class AddFedToFish < ActiveRecord::Migration[7.1]
  def change
    add_column :fish, :fed, :boolean, default: false
  end
end
