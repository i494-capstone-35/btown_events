class Event < ActiveRecord::Base
  belongs_to :facility
  belongs_to :event

  before_save :time_dates, :category_empty
  after_validation :recurrence_defined

  validates_presence_of :name, :date

  scope :weeks_events, lambda { |time| \
    where(:start_time => (time.beginning_of_week..time.end_of_week)) }
  scope :months_events, lambda { |time| \
    where(:start_time => (time.beginning_of_month..time.end_of_month)) }
  scope :categories, lambda { |c| where(:category => c) }
  scope :categories_day, lambda { |c, d| where(:category => c, :date => d) }

  # sort by attribute uniquely
  # Event.uniq_by array_of_objects, &:attribute
  def self.uniq_by(array)
    array.inject({}) do |acc, obj|
      value = yield(obj)
      acc[value] ||= []
      acc[value].push obj
      acc
    end.map do |(key, value)|
      value.first
    end
  end

  private
  def time_dates
    unless start_time.nil?
      self.start_time = "#{date.strftime("%h %d")} #{start_time.strftime("%R")}"
      unless end_time.nil? # check this first
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
      # recurrence should look like "<num>[d,w,m]<times>"
      # or if it's a bar special, omit the times since it defaults to 3 months
      interval = Integer recurrence[0].chr
      string = recurrence[1].chr
      if category == "Bar Special" && recurrence == "1w"
        term = 12
      else
        term = Integer recurrence[2].chr
      end

      recur = lambda do |x|
        case string
        when 'd' then
          (x * interval).days
        when 'w' then
          (x * interval).weeks
        when 'm' then
          (x * interval).months
        end
      end

      # has the effect of saving all clones before the original
      1.upto(term) do |i|
        clone = self.clone
        clone.date += recur.call i
        clone.recurrence = nil
        clone.save
      end
    end
  end
end
