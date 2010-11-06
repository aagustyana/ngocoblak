class AddLinkToItems < ActiveRecord::Migration
  def self.up
    add_column :items,:link,:string
    add_column :items,:permalink,:string
  end

  def self.down
    remove_column :items,:link
    remove_column :items,:permalink
  end
end
