class Event < ActiveRecord::Base
  belongs_to :facility
  belongs_to :event

  before_save :time_dates, :category_empty
  after_validation :recurrence_defined

  validates_presence_of :name, :date

  scope :weeks_events, lambda { |time| 
    where(:date => (time.beginning_of_week..time.end_of_week)) }
  scope :months_events, lambda { |time| 
    where(:date => (time.beginning_of_month..time.end_of_month)) }
  scope :categories, lambda { |c| where(:category => c)}

  private
    def time_dates
      unless start_time.nil?
        self.start_time = "#{date.strftime("%h %d")} #{start_time.strftime("%R")}"
        unless end_time.nil?
          unless start_time.hour > end_time.hour
            self.end_time = "#{date.strftime("%h %d")} #{end_time.strftime("%R")}"
          end
        end
      end
    end

    def category_empty
      if category.nil?
        self.category = "Misc"
      end
    end

    def recurrence_defined
      unless recurrence.nil?
        number = Integer recurrence[0].chr
        string = recurrence[1].chr
        if category == "Bar Specials" && recurrence == "1w"
          term = 12
        else 
          term = Integer recurrence[2].chr
        end
        unless number == 0
          case string
          when 'w' then
            num = 7.days
          when 'd' then
            num = 1.days 
          when 'm' then
            num = 1.month
          end
        end
      end
    end
end
