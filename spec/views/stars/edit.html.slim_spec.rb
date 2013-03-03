require 'spec_helper'

describe "stars/edit" do
  before(:each) do
    @star = assign(:star, stub_model(Star,
      :x => 1,
      :y => 1,
      :name => "MyString",
      :description => "MyText",
      :active => false
    ))
  end

  it "renders the edit star form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stars_path(@star), :method => "post" do
      assert_select "input#star_x", :name => "star[x]"
      assert_select "input#star_y", :name => "star[y]"
      assert_select "input#star_name", :name => "star[name]"
      assert_select "textarea#star_description", :name => "star[description]"
      assert_select "input#star_active", :name => "star[active]"
    end
  end
end
