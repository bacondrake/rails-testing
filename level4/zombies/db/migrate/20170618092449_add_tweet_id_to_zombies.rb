class AddTweetIdToZombies < ActiveRecord::Migration[5.1]
  def change
    add_column :zombies, :tweet_id, :integer
    add_index :zombies, :tweet_id
  end
end
