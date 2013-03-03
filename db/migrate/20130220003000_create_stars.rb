class CreateStars < ActiveRecord::Migration
  def change
    create_table :stars do |t|
      t.integer :x
      t.integer :y
      t.string :name
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end
end
