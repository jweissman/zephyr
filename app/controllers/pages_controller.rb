class PagesController < ApplicationController

  skip_authorization_check

  def root
    redirect_to :games if logged_in?
  end

  def games
  end

  def pong
    redirect_to :games unless logged_in?
  end
end
