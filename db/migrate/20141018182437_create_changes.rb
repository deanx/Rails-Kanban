class CreateChanges < ActiveRecord::Migration
  def change
    create_table :changes do |t|
      t.references :story, index: true
      t.references :user, index: true
      t.belongs_to :state_from
      t.belongs_to :state_to
      t.datetime :date

      t.timestamps
    end
  end
end
