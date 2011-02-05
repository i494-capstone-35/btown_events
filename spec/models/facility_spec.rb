require 'spec_helper'

describe Facility do
  before do
    @facility = Factory.build(:facility)
  end

  context 'attributes' do
    it 'has a name' do
      @facility.name.should == "Bar Pub Club Stage Place"
    end
  end
end
