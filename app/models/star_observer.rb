class StarObserver < ActiveRecord::Observer
  include BackboneSync::Rails::Faye::Observer
end
