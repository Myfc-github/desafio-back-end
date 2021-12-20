class RemoveAccountFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_reference :users, :account, foreign_key: true
  end
end
