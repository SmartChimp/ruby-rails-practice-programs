class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.string :address
      t.float :cost_per_day
      t.integer :home_type
      t.integer :room_type

      t.timestamps
    end
  end
end
