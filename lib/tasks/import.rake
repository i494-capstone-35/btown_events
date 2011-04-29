namespace :db do
  desc "Import CSV of Events"

  task :import => :environment do
    # import facilities before events for dependencies

    rows = []
    Excelsior::Reader.rows(File.open("#{Dir.pwd}/db/Facilities.csv", 'rb')) do |row|
      rows << row
    end

    columns = [:name, :number, :address, :website, :image, :s_name]
    1.upto(rows.count - 1) do |row|
      attrs = rows[row]
      if File.exist?(Rails.root + "public/images/logos/#{image}.png")
        # remove any spaces, ampersands, and colons in the name
        attrs[4] = attrs[0].gsub /[\s\*&':]+/,""
      end
      # remove articles from beginning of name
      attrs[5] = attrs[0].sub /^(the|a|an)\s+/i, ''
      Facility.create(Hash[columns.zip(attrs)])
    end

    rows = []
    Excelsior::Reader.rows(File.open("#{Dir.pwd}/db/Events\ Schedule.csv", 'rb')) do |row|
      rows << row
    end

    columns = [:name, :facility, :date, :start_time, :end_time, :address, :recurrence, :category, :event, :admission, :description]
    n = rows.count - 1
    (1..n).each do |row|
      attrs    = rows[row]
      attrs[1] = Facility.find_by_name(attrs[1]) unless attrs[1].nil?
      attrs[8] = Event.find_by_name(attrs[8]) unless attrs[8].nil?
      Event.create(Hash[columns.zip(attrs)])
    end
  end

  task :real => ["db:reset", "db:import"]
end
