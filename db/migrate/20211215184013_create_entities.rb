class CreateEntities < ActiveRecord::Migration[6.1]
  def change
    create_table :entities do |t|
      t.string :name
      t.references :account, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
