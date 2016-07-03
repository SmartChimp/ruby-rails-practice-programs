class CreateUsers < ActiveRecord::Migration
  def up
	create_table :users do |t|
		t.string :email
		t.string :password_diggest
		t.string :salt
		t.string :firstname
		t.string :lastname

		t.timestamps
	end
  end

  def down
  end
end
