class CreateWeapons < ActiveRecord::Migration[5.1]
  def change
    create_table :weapons do |t|
      t.integer :zombie_id
      t.timestamps
    end

    add_index :weapons, :zombie_id
  end
end
