Factory.create(:facility, :name => "BarPubStein")
Facility.create(
  :name    => "IU Auditorium",
  :number  => "812-855-1033",
  :address => "1211 East Seventh Street Bloomington, IN 47405-5501",
  :website => "www.iuauditorium.com")

5.times do |n|
  Factory.create(:event, 
                 :name     => "Event \##{Event.count + 1 + n}",
                 :date     => Date.today + (rand(14) + 1).days,
                 :category => String (n % 2 == 0 ? n : n - 1)
                )
end
