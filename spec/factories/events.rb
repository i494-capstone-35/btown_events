Factory.define :event do |e|
  e.name "Birthday Party"
  e.date Date.today
  e.start_time "12:00"
  e.end_time "16:20"
  e.address "123 April's House"
  e.category "Celebration"
  #e.recurrence "4w"
end
