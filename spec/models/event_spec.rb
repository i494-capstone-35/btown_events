require 'spec_helper'

describe Event do
  before do
    @event = Event.new
  end

  context 'valid format' do
    it 'has a start time' do
      @event.start_time = "2:00"
      @event.start_time.strftime("%H:%M").should == "02:00"
    end
  end
end
