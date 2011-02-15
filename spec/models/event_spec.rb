require 'spec_helper'

describe Event do
  before do
    @event = Event.new
    @factory = Factory.build(:event)
    @events = Event.all
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
  context 'creates the right number of clones' do
    it 'right clones for days' do
      @factory.recurrence = "4d"
      expect { @factory.save }.to change { Event.count }.by(5)
    end
    it 'right clones for weeks' do
      @factory.recurrence = "3w"
      expect { @factory.save }.to change { Event.count }.by(4)
    end
    it 'right clones for months' do
      @factory.recurrence = "2m"
      expect { @factory.save }.to change { Event.count }.by(3)
    end
    it 'right clones for 0 n' do
      @factory.recurrence = "0"
      expect { @factory.save }.to change { Event.count }.by(0)
    end
  end
  it 'changes the date correctly' do
    @factory.recurrence = "3d"
  end
end
