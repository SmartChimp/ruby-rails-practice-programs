class CreateAmenities < ActiveRecord::Migration
  def change
    create_table :amenities do |t|

      t.timestamps
    end
  end
end
