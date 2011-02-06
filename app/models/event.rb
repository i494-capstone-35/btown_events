class Event < ActiveRecord::Base
  belongs_to :facility

  #validates_presence_of :name, :date, :start_time, :end_time
  # validates_uniqueness_of :name
end
