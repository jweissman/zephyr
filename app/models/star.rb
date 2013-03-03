class Star < ActiveRecord::Base
  attr_accessible :active, :description, :name, :x_pos, :y_pos, :x, :y

  alias_attribute :x_pos, :x
  alias_attribute :y_pos, :y
end
