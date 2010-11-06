class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :title
      t.float :price
      t.integer :feed_id

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
