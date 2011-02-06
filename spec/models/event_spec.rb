require 'spec_helper'

describe Event do
  before do
    @event = Event.new
  end

  context 'valid format' do
    it 'has a valid start time' do
      @event.start_time = "2:00"
      @event.start_time.strftime("%H:%M").should == "02:00"
      @event.start_time.strftime("%D").should == Time.now.strftime("%D")
    end
    it 'has a valid end time' do
      @event.end_time = "2:00"
      @event.end_time.strftime("%H:%M").should == "02:00"
      @event.end_time.strftime("%D").should == Time.now.strftime("%D")
    end
    it 'has a valid date' do
      @event.date = "4/20/2012 16:20"
      @event.date.strftime("%D").should == "04/20/12"
      @event.date.strftime("%T").should == "16:20:00"
    end
    it 'has a unique name' do
      @event.name = "Culture Shock"
      #@event.name.should be_unique
    end
    it 'has a unique address' do

    end
  end
end
