class CreateLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.string :screen_name
      t.integer :tweet_id
      t.text :url
      t.text :title
      t.string :state
      t.timestamps
    end
    add_index :links, :screen_name
    add_index :links, :state
  end
end