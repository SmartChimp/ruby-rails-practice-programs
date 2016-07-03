class AddRoomTypeIdToSpace < ActiveRecord::Migration
  def change
    add_column :spaces, :room_id, :integer
  end
end
