class AddColumnToSpace < ActiveRecord::Migration
  def change
    add_column :spaces, :beds_count, :integer
  end
end
