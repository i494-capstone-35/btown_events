require 'spec_helper'

describe Facility do
  before do
    @facility = Factory.build(:facility)
  end

  context 'attributes' do
    it 'has a name' do
      @facility.valid?
      @facility.name.should == "Bar Pub Club Stage Place"
    end

    it 'has a phone number' do
      @facility.valid?
      @facility.number.should == "812-888-8888"
    end
    
    it 'has an address' do
      @facility.valid?
      @facility.address.should == "1 Kirkwood"
    end

    it 'has a website' do
      @facility.valid?
      @facility.website.should == "www.restaurantflashmenu.com"
    end
  end
end
