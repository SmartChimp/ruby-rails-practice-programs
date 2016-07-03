class AddFieldNameToAmenity < ActiveRecord::Migration
  def change
    add_column :amenities, :description, :string
  end
end
