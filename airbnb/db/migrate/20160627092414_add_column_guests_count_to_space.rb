class AddColumnGuestsCountToSpace < ActiveRecord::Migration
  def change
    add_column :spaces, :max_guests_count, :integer
  end
end
