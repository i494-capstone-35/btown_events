class CreateFacilities < ActiveRecord::Migration
  def self.up
    create_table :facilities do |t|
      t.string :name
      t.string :number
      t.string :address
      t.string :website
      t.timestamps
    end
  end

  def self.down
    drop_table :facilities
  end
end
