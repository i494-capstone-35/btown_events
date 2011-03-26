class AddImageToFacility < ActiveRecord::Migration
  def self.up
    add_column :facilities, :image, :string
  end

  def self.down
    remove_column :facilities, :image
  end
end
