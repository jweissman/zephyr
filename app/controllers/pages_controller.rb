class PagesController < ApplicationController

  skip_authorization_check
  before_filter :require_sign_in, except: :root

  def root
    redirect_to :games if logged_in?
  end

  def games
    #redirect_to :sign_in unless logged_in?
  end

  def pong
    #redirect_to :sign_in unless logged_in?
  end

  def lobby
    #redirect_to :sign_in unless logged_in?
  end

  protected

  def require_sign_in
    redirect_to :sign_in unless logged_in?
  end
end
