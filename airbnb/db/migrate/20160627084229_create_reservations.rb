class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.date :to_date
      t.date :from_date
      t.integer :no_of_guests
      t.integer :city_id
      t.integer :room_type

      t.timestamps
    end
  end
end
