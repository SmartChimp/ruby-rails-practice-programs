class CreateReservedGuests < ActiveRecord::Migration
  def change
    create_table :reserved_guests do |t|
      t.integer :guests_count
      t.date :calendar_date
      t.integer :space_id
      t.integer :lock_version

      t.timestamps
    end

    add_index :reserved_guests, [:calendar_date, :space_id], :unique => true
    change_column :reserved_guests, :space_id, :integer, :null => false
    change_column :reserved_guests, :calendar_date, :date, :null => false
  end
end
