class Event < ActiveRecord::Base
  belongs_to :facility
  belongs_to :event

  before_save :time_dates, :category_empty
  after_validation :recurrence_defined

  validates_presence_of :name, :date

  scope :weeks_events, lambda { |time| \
    where(:date => (time.beginning_of_week..time.end_of_week)) }
  scope :categories, lambda { |c| where(:category => c) }
  scope :weeks_events_categories, lambda { |time, category| \
    where(:date => (time.beginning_of_week..time.end_of_week), :category => category) }
  scope :categories_day, lambda { |c, d| where(:category => c, :date => d) }

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
      string   = recurrence[1].chr
      term = if category == "Bar Special" && recurrence == "1w"
               12
             else
               Integer recurrence[2].chr
             end

      # calculate the integer value before the DateTime object
      # fixes some weird issues with DateTime
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
        clone            = self.clone
        clone.date      += recur.call i
        clone.recurrence = nil
        clone.save
      end
    end
  end
end
