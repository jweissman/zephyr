require 'spec_helper'

describe "stars/index" do
  before(:each) do
    assign(:stars, [
      stub_model(Star,
        :x => 1,
        :y => 2,
        :name => "Name",
        :description => "MyText",
        :active => false
      ),
      stub_model(Star,
        :x => 1,
        :y => 2,
        :name => "Name",
        :description => "MyText",
        :active => false
      )
    ])
  end

  it "renders a list of stars" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
