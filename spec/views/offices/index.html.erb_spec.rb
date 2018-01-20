require 'rails_helper'

RSpec.describe "offices/index", type: :view do
  before(:each) do
    assign(:offices, [
      Office.create!(
        :name => "Name",
        :country => "Country",
        :postcode => "Postcode",
        :street_ad => "Street Ad",
        :town_city => "Town City",
        :phone_no => "Phone No",
        :county => "County"
      ),
      Office.create!(
        :name => "Name",
        :country => "Country",
        :postcode => "Postcode",
        :street_ad => "Street Ad",
        :town_city => "Town City",
        :phone_no => "Phone No",
        :county => "County"
      )
    ])
  end

  it "renders a list of offices" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => "Postcode".to_s, :count => 2
    assert_select "tr>td", :text => "Street Ad".to_s, :count => 2
    assert_select "tr>td", :text => "Town City".to_s, :count => 2
    assert_select "tr>td", :text => "Phone No".to_s, :count => 2
    assert_select "tr>td", :text => "County".to_s, :count => 2
  end
end
