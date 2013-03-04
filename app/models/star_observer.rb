class StarObserver < ActiveRecord::Observer
  # ...?
  #include ApplicationHelper
  include BackboneSync::Rails::Faye::Observer
  #def after_create(star)
  #  broadcast "/messages/new" do
  #    "new star created at #{star.x} #{star.y}"
  #  end
  #end
end
