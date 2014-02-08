class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :real_name
      t.string :password_digest
      t.point :location, :geographic => true, :srid => 4326
      t.timestamps
    end
  end
end
