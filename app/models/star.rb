class Star < ActiveRecord::Base
  attr_accessible :active, :description, :name, :x, :y, :layer
  #
  #before_create :assign_layer
  #
  #def assign_layer
  #  self.layer = Integer(rand()*4)
  #  true
  #end

  def self.faye_channel; 'stars' end
  def self.at(x,y)
    Star.new :x => x, :y => y
  end

  def self.random
    Star.at rand*1024, rand*800
  end
end
