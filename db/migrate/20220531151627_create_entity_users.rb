class CreateEntityUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :entity_users do |t|
      t.references :entity, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
