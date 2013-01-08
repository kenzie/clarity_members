class AddTwitterUserIdToLinksAndUsers < ActiveRecord::Migration
  def up
    add_column :links, :twitter_user_id, :integer
    add_column :users, :twitter_user_id, :integer
    add_index :links, :twitter_user_id
    add_index :users, :twitter_user_id
  end

  def down
    remove_column :links, :twitter_user_id
    remove_column :users, :twitter_user_id
    remove_index :links, :twitter_user_id
    remove_index :users, :twitter_user_id
  end
end