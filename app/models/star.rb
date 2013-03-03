class Star < ActiveRecord::Base
  attr_accessible :active, :description, :name, :x, :y
  def self.faye_channel; 'stars' end
end
