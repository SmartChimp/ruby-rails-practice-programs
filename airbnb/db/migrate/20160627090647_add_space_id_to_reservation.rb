class AddSpaceIdToReservation < ActiveRecord::Migration
  def change
    add_column :reservations, :space_id, :integer
  end
end
