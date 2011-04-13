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
      @factory.start_time = "#{Date.tomorrow} 2:00"
      @factory.start_time.strftime("%H:%M").should == "02:00"
      expect { @factory.save }.to change { @factory.start_time.day }.to @factory.date.day
    end
    it 'has a valid end time' do
      @factory.start_time = "01:00"
      @factory.end_time = "#{Date.tomorrow} 2:00"
      @factory.end_time.strftime("%H:%M").should == "02:00"
      expect { @factory.save }.to change { @factory.end_time.day }.to @factory.date.day
    end
    it 'has a valid end time tomorrow' do
      @factory.end_time = "#{@factory.end_time.tomorrow.strftime("%h %da")} 01:00"
      @factory.save
      @factory.end_time.day.should_not == @factory.date.day
    end
  end

  context 'creates the right number of clones' do
    it 'for days' do
      @factory.recurrence = "4d2"
      # When saved, it creates a new one itself so always + 1 to num of times
      expect { @factory.save }.to change { Event.count }.by(3)

      # Check similarity by name and recurrence set
      @factory.name.should == Event.find_by_date(@factory.date + 4.days).name
      @factory.name.should == Event.find_by_date(@factory.date + 8.days).name
    end
    it 'for weeks' do
      @factory.recurrence = "3w1"
      expect { @factory.save }.to change { Event.count }.by(2)
      @factory.name.should == Event.find_by_date(@factory.date + 21.days).name
    end
    it 'for months' do
      @factory.recurrence = "2m3"
      expect { @factory.save }.to change { Event.count }.by(4)

      @factory.name.should == Event.find_by_date(@factory.date + 2.months).name
      @factory.name.should == Event.find_by_date(@factory.date + 4.months).name
      @factory.name.should == Event.find_by_date(@factory.date + 6.months).name
    end
  end
  it 'changes the date correctly' do
  end
  context 'returns the right block of events for category' do
    let (:f2) { Factory.build(:event, :name => "f2", :category => "Two") }
    before :each do
      f2
    end
    it 'is returned from categories search' do
      @factory.update_attributes(:category => "One")
      (Event.categories @factory.category).should_not include(f2)
    end
  end

  # tests for `rake db:import; rake db:real`
  context 'imports the data' do
    before do
      @reject = ["id", "updated_at", "created_at"] 
    end
    it 'creates a column for each Event attribute' do
      columns = [:name, :facility_id, :date, :start_time, :end_time, :address, :recurrence, :category, :admission, :description, :event_id].
        map(&:to_s).sort
      columns.should == (Event.column_names - @reject).sort
    end
    
    it 'creates a column for each Facility attribute' do
      columns = [:name, :number, :address, :website, :image, :s_name].map(&:to_s).sort
      columns.should == (Facility.column_names - @reject).sort
    end
  end
end
