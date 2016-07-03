class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|
      t.string :home_type

      t.timestamps
    end
  end
end
