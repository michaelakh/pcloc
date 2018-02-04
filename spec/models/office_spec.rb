require 'rails_helper'

RSpec.describe Office, type: :model do
  describe Office do
    it "has a valid factory" do
      create(:office).should be_valid
    end
    
    it "is invalid without a name" do
      build(:office, name: nil).should_not be_valid
    end
  
    it "is invalid without a country" do
      build(:office, country: nil).should_not be_valid
    end
    
    it "is invalid without a postcode" do
      build(:office, postcode: nil).should_not be_valid
    end
    
    it "is invalid without a unique postcode" do
      office1 = create(:office, postcode: "76032-4907")
      
      build(:office, postcode: "76032-4907").should_not be_valid
    end
    
    it "is invalid without a street address" do
      build(:office, street_ad: nil).should_not be_valid
    end
    
    it "is invalid without a town or city" do
      build(:office, town_city: nil).should_not be_valid
    end
    
    it "is invalid without a phone number" do
      build(:office, phone_no: nil).should_not be_valid
    end
    
    it "returns an office credentials" do
      office = build(:office, name: "Brinks Office", country: "United Kingdom", street_ad: "99 brink Avenue", phone_no: "07912345678")
      office.display_office.should == "Brinks Office United Kingdom 99 brink Avenue 07912345678"
    end
  end
end
