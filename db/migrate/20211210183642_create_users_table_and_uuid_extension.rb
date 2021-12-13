class CreateUsersTableAndUuidExtension < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL.squish
      CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
    SQL

    create_table :users do |t|
      t.uuid :uuid, default: 'uuid_generate_v4()' # rubocop:disable Style/StringLiterals
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :phone, null: false
      t.datetime :confirmed_at
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    execute <<-SQL.squish
      DROP TABLE if exists users cascade;
      DROP EXTENSION "uuid-ossp";
    SQL
  end
end
