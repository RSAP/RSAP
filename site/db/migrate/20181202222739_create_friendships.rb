class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id
	  t.boolean :accepted, default: false

	  t.timestamps null: false
    end
  end
end
