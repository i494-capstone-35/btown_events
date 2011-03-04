class Event < ActiveRecord::Base
  belongs_to :facility
  belongs_to :event

  before_save :time_dates
  def time_dates
    self.start_time = "#{date.strftime("%h %d")} #{start_time.strftime("%R")}"
    unless start_time.hour > end_time.hour
      self.end_time = "#{date.strftime("%h %d")} #{end_time.strftime("%R")}"
    else
      self.end_time = "#{(date + 1.days).strftime("%h %d")} #{end_time.strftime("%R")}"
    end
  end

  validates_presence_of :name, :date, :start_time, :end_time

  scope :weeks_events, lambda { |time| 
    where(:date => (time.beginning_of_week..time.end_of_week)) }
  scope :months_events, lambda { |time| 
    where(:date => (time.beginning_of_month..time.end_of_month)) }
  scope :categories, lambda { |c| where(:category => c)}

  after_validation :recurrence_defined

  def recurrence_defined
    unless recurrence.nil?
      number = Integer recurrence[0,1]
      string = recurrence[1,2]
      r = []
      unless number == 0
        case string
        when 'w' then
          num = 7.days
        when 'd' then
          num = 1.days 
        when 'm' then
          num = 1.month
        end
        while number > 0
          clone = self.clone
          unless r.empty?
            clone.date = r[0] + num
            clone.start_time = r[1] + num
            clone.end_time = r[2] + num
          else
            clone.date = self.date.to_datetime + num
            clone.start_time = self.start_time.to_datetime + num
            clone.end_time = self.end_time.to_datetime + num
          end
          clone.recurrence = nil
          clone.save
          r = [clone.date, clone.start_time, clone.end_time]
          number -= 1
        end
      end
    end
  end
end
