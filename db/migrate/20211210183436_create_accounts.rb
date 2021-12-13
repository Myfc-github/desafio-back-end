class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :phone
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
