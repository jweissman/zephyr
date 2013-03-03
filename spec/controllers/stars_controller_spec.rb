require 'spec_helper'

describe StarsController do

  # This should return the minimal set of attributes required to create a valid
  # Star. As you add validations to Star, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    attributes_for :star
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # StarsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  before do
    login_user build :user
  end

  describe "#index" do
    it "assigns all stars as @stars" do
      star = Star.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:stars)).to eq([star])
    end
  end

  describe "#show" do
    it "assigns the requested star as @star" do
      star = Star.create! valid_attributes
      get :show, { :id => star.to_param }, valid_session
      expect(assigns(:star)).to eq(star)
    end
  end

  describe "#new" do
    it "assigns a new star as @star" do
      get :new, {}, valid_session
      expect(assigns(:star)).to be_a_new(Star)
    end
  end

  describe "#edit" do
    it "assigns the requested star as @star" do
      star = Star.create! valid_attributes
      get :edit, { :id => star.to_param }, valid_session
      expect(assigns(:star)).to eq(star)
    end
  end

  describe "#create" do
    describe "with valid params" do
      it "creates a new Star" do
        expect {
          post :create, { :star => valid_attributes }, valid_session
        }.to change(Star, :count).by(1)
      end

      it "assigns a newly created star as @star" do
        post :create, {:star => valid_attributes }, valid_session
        expect(assigns(:star)).to be_a(Star)
        expect(assigns(:star)).to be_persisted
      end

      it "redirects to the created star" do
        post :create, { :star => valid_attributes }, valid_session
        expect(response).to redirect_to(Star.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved star as @star" do
        # Trigger the behavior that occurs when invalid params are submitted
        Star.any_instance.stub(:save).and_return(false)
        post :create, { :star => { "x" => "invalid value" } }, valid_session
        expect(assigns(:star)).to be_a_new(Star)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Star.any_instance.stub(:save).and_return(false)
        post :create, { :star => { "x" => "invalid value" } }, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "#update" do
    describe "with valid params" do
      it "updates the requested star" do
        star = Star.create! valid_attributes
        # Assuming there are no other stars in the database, this
        # specifies that the Star created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Star.any_instance.should_receive(:update_attributes).with({ "x" => "1" })
        put :update, { :id => star.to_param, :star => { "x" => "1" } }, valid_session
      end

      it "assigns the requested star as @star" do
        star = Star.create! valid_attributes
        put :update, { :id => star.to_param, :star => valid_attributes }, valid_session
        expect(assigns(:star)).to eq(star)
      end

      it "redirects to the star" do
        star = Star.create! valid_attributes
        put :update, { :id => star.to_param, :star => valid_attributes }, valid_session
        expect(response).to redirect_to(star)
      end
    end

    describe "with invalid params" do
      it "assigns the star as @star" do
        star = Star.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Star.any_instance.stub(:save).and_return(false)
        put :update, { :id => star.to_param, :star => { "x" => "invalid value" } }, valid_session
        expect(assigns(:star)).to eq(star)
      end

      it "re-renders the 'edit' template" do
        star = Star.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Star.any_instance.stub(:save).and_return(false)
        put :update, { :id => star.to_param, :star => { "x" => "invalid value" } }, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "#destroy" do
    it "destroys the requested star" do
      star = Star.create! valid_attributes
      expect {
        delete :destroy, { :id => star.to_param }, valid_session
      }.to change(Star, :count).by(-1)
    end

    it "redirects to the stars list" do
      star = Star.create! valid_attributes
      delete :destroy, { :id => star.to_param }, valid_session
      expect(response).to redirect_to(stars_url)
    end
  end

end
