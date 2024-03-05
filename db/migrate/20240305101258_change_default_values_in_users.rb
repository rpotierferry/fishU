class ChangeDefaultValuesInUsers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :currency, 0
  end
end
