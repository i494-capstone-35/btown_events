class AddEventsToFacilities < ActiveRecord::Migration
  def self.up
    add_column :events, :facility_id, :integer
  end

  def self.down
    remove_column :events, :facility_id
  end
end
