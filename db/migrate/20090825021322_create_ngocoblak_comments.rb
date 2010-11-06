class CreateNgocoblakComments < ActiveRecord::Migration
  def self.up
    create_table :ngocoblak_comments do |t|
      t.text :content
      t.boolean :status
      t.timestamps
    end
  end

  def self.down
    drop_table :ngocoblak_comments
  end
end
