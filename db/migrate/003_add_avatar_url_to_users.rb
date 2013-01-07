class AddAvatarUrlToUsers < ActiveRecord::Migration
  def up
    add_column :users, :avatar_url, :text
  end

  def down
    remove_column :users, :avatar_url
  end
end