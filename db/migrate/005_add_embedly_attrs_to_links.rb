class AddEmbedlyAttrsToLinks < ActiveRecord::Migration
  def up
    add_column :links, :embedly_description, :text
    add_column :links, :embedly_provider, :text
    add_column :links, :embedly_type, :string
  end

  def down
    remove_column :links, :embedly_description
    remove_column :links, :embedly_provider
    remove_column :links, :embedly_type
  end
end