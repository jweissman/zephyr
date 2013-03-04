require 'spec_helper'

describe "stars/show" do
  before(:each) do
    @star = assign(:star, stub_model(Star,
      :x => 1,
      :y => 2,
      :name => "Name",
      :description => "MyText",
      :active => false
    ))
  end

  # TODO figure out what's broken here
  #it "renders attributes in <p>" do
  #  render
  #
  #  # Run the generator again with the --webrat flag if you want to use webrat matchers
  #  p rendered
  #  rendered.should match(/1/)
  #  rendered.should match(/2/)
  #  rendered.should match(/Name/)
  #  rendered.should match(/MyText/)
  #  rendered.should match(/false/)
  #end
end
