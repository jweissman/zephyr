class StarsController < ApplicationController

  load_and_authorize_resource

  respond_to :html, :json

  def index
    respond_to do |format|
      format.json { render :json => @stars.as_json }
      format.html
    end
  end

  def show
    respond_to do |format|
      format.json { render :json => @star.as_json }
      format.html
    end
  end

  def new
  end

  def edit
  end

  def create
    @star = Star.new(params[:star])

    if @star.save!
      redirect_to @star, notice: 'Star was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @star.update_attributes(params[:star])
      redirect_to @star, notice: 'Star was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy_all

    Star.delete_all()
    respond_to do |format|
      format.html { redirect_to stars_url }
      format.json { head :no_content }
    end
    return

  end

  def destroy
    @star.destroy
    redirect_to stars_url
  end
end
