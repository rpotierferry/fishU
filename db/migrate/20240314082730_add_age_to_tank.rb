class AddAgeToTank < ActiveRecord::Migration[7.1]
  def change
    add_column :tanks, :age, :integer, default: 1
  end
end
