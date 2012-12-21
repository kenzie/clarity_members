class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :clarity_screen_name
      t.string :twitter_screen_name
      t.text :aliases
      t.timestamps
    end
    add_index :users, :twitter_screen_name
  end
end