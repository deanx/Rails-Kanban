class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.string :code
      t.integer :points

      t.timestamps
    end
    add_index :stories, :code, unique: true
  end
end
