class AddCurrencyToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :currency, :integer
  end
end
