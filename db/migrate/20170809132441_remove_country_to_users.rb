class RemoveCountryToUsers < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :country, :string
    remove_column :users, :city, :string
  end
end
