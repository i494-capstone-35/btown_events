require 'spec_helper'

describe Event do
  before do
    @factory = Factory.build(:event)
    @events = Event.all
  end

  context 'valid format' do
    it 'has a valid date' do
      @factory.date = "4/20/2012 16:20"
      @factory.date.strftime("%D").should == "04/20/12"
      @factory.date.strftime("%T").should == "16:20:00"
    end
    it 'has a valid start time' do
      @factory.start_time = "2:00"
      @factory.start_time.strftime("%H:%M").should == "02:00"
      expect { @factory.save }.to change { @factory.start_time.day }.to @factory.date.day
    end
    it 'has a valid end time' do
      @factory.end_time = "2:00"
      @factory.end_time.strftime("%H:%M").should == "02:00"
      expect { @factory.save }.to change { @factory.end_time.day }.to @factory.date.day
    end
    it 'has a valid end time tomorrow' do
      @factory.end_time = "#{@factory.end_time.tomorrow.strftime("%h %da")} 01:00"
      @factory.save
      @factory.end_time.day.should_not == @factory.date.day
    end
    it 'has a unique name' do
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
