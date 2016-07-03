class AddHomeTypeIdToSpace < ActiveRecord::Migration
  def change
    add_column :spaces, :home_id, :integer
  end
end
