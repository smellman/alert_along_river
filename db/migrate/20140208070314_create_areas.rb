class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.column :area, :geometry, :geographic => true, :srid => 4326
      t.integer :left
      t.integer :right
      t.integer :parent_left
      t.integer :parent_right
      t.timestamps
    end
  end
end
