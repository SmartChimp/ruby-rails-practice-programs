class AddColumnBathToSpace < ActiveRecord::Migration
  def change
    add_column :spaces, :bathrooms_count, :integer
  end
end
