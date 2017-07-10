class AddStatusToZombies < ActiveRecord::Migration[5.1]
  def change
    add_column :zombies, :status, :string
  end
end
