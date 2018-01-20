require 'rails_helper'

RSpec.describe "offices/show", type: :view do
  before(:each) do
    @office = assign(:office, Office.create!(
      :name => "Name",
      :country => "Country",
      :postcode => "Postcode",
      :street_ad => "Street Ad",
      :town_city => "Town City",
      :phone_no => "Phone No",
      :county => "County"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Country/)
    expect(rendered).to match(/Postcode/)
    expect(rendered).to match(/Street Ad/)
    expect(rendered).to match(/Town City/)
    expect(rendered).to match(/Phone No/)
    expect(rendered).to match(/County/)
  end
end
