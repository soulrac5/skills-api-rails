class AddCodeToRols < ActiveRecord::Migration[5.1]
  def change
    add_column :rols, :code, :integer
  end
end
