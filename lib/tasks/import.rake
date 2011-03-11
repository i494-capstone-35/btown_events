namespace :db do
  desc "Import CSV of Events"

  task :import => :environment do
    rows = []
    Excelsior::Reader.rows(File.open("#{Dir.pwd}/db/Events\ Schedule.csv", 'rb')) do |row|
      rows << row
    end

    columns = [:name, :facility, :date, :start_time, :end_time, :address, :recurrence, :category, :event]
    n = rows.count - 1
    (1..n).each do |row|
      attrs = rows[row]
      attrs[1] = Facility.find_by_name(attrs[1]) unless attrs[1].nil?
      attrs[8] = Event.find_by_name(attrs[8]) unless attrs[8].nil?
      Event.create(Hash[columns.zip(attrs)])
    end
  end

  task :real => ["db:reset", "db:import"]
end
