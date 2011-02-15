class AddRecurrenceToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :recurrence, :string
  end

  def self.down
    remove_column :events, :recurrence
  end
end
