facility = Factory.build(:facility, :name => "BarPubStein")
facility.save

5.times { Factory.build(:event).save }
