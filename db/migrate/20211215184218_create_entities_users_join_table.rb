class CreateEntitiesUsersJoinTable < ActiveRecord::Migration[6.1]
  def change
    create_join_table :entities, :users
  end
  def up
    create_table :entities_users, :id => false do |t|
      t.integer :entity_id
      t.integer :user_id
    end
  
    add_index :entities_users, %i[:entity_id :user_id]
  end
  
  def down
    drop_table :entities_users
  end
end
