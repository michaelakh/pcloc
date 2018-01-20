require 'rails_helper'

RSpec.describe "offices/new", type: :view do
  before(:each) do
    assign(:office, Office.new(
      :name => "MyString",
      :country => "MyString",
      :postcode => "MyString",
      :street_ad => "MyString",
      :town_city => "MyString",
      :phone_no => "MyString",
      :county => "MyString"
    ))
  end

  it "renders new office form" do
    render

    assert_select "form[action=?][method=?]", offices_path, "post" do

      assert_select "input#office_name[name=?]", "office[name]"

      assert_select "input#office_country[name=?]", "office[country]"

      assert_select "input#office_postcode[name=?]", "office[postcode]"

      assert_select "input#office_street_ad[name=?]", "office[street_ad]"

      assert_select "input#office_town_city[name=?]", "office[town_city]"

      assert_select "input#office_phone_no[name=?]", "office[phone_no]"

      assert_select "input#office_county[name=?]", "office[county]"
    end
  end
end
