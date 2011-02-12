class Event < ActiveRecord::Base
  belongs_to :facility

  unless Date.today.leap?
    feb = 28
  else
    feb = 29
  end
  MONTHS = [31,feb,31,30,31,30,31,31,30,31,30,31]

  current_month = Integer Time.now.strftime("%m")
  days = MONTHS[current_month]
  #m = Integer Time.now.strftime("%m")

  named_scope :months_events, lambda { |time| where(:date => (time.beginning_of_month..time.end_of_month)) }
end
