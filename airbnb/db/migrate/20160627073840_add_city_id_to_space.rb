class AddCityIdToSpace < ActiveRecord::Migration
  def change
    add_column :spaces, :city_id, :integer
  end
end
