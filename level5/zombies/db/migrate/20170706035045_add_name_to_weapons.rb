class AddNameToWeapons < ActiveRecord::Migration[5.1]
  def change
    add_column :weapons, :name, :string
  end
end
