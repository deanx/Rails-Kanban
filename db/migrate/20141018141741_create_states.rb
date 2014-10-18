class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :title
      t.integer :order

      t.timestamps
    end
    add_index :states, :title, unique: true
    add_index :states, :order, unique: true
  end
end
