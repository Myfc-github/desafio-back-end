class RemoveAccountFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_reference :users, :account, index: true, foreign_key: true
  end
end
