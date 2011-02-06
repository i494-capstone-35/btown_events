class Facility < ActiveRecord::Base
  has_many :events

  #validates_presence_of   :name,:address,:website
  #validates_uniqueness_of :name,:address,:website
end
