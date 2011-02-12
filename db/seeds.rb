facility = Factory.build(:facility, :name => "BarPubStein")
facility.save

event = Factory.build(:event)
event.save
