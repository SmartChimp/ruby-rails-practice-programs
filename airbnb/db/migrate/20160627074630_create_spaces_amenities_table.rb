class CreateSpacesAmenitiesTable < ActiveRecord::Migration
  def up
	create_table :spaces_amenities, :id => false do |t|
		t.references :space
		t.references :amenity
	end
	add_index :spaces_amenities, [:space_id, :amenity_id]
  end

  def down
  end
end
