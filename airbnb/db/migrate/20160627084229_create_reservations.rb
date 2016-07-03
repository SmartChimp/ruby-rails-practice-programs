class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.date :to_date
      t.date :from_date

      t.timestamps
    end
  end
end
