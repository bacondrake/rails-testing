class AddWeaponIdToZombies < ActiveRecord::Migration[5.1]
  def change
    add_column :zombies, :weapon_id, :integer
    add_index :zombies, :weapon_id
  end
end
