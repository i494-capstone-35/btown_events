class AddSortableNameToFacility < ActiveRecord::Migration
  def self.up
    add_column :facilities, :s_name, :string
  end

  def self.down
    remove_column :facilities, :s_name
  end
end
