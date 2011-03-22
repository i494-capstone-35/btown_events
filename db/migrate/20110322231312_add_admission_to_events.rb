class AddAdmissionToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :admission, :text
  end

  def self.down
    remove_column :events, :admission
  end
end
