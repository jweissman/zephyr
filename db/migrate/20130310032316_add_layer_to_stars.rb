class AddLayerToStars < ActiveRecord::Migration
  def change
    add_column :stars, :layer, :integer
  end
end
