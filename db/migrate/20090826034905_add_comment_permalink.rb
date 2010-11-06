class AddCommentPermalink < ActiveRecord::Migration
  def self.up
    add_column :ngocoblak_comments, :permalink, :string
  end

  def self.down
    remove_column :ngocoblak_comments, :permalink
  end
end
