class AddIndexToUsersEmail < ActiveRecord::Migration[5.0]
  def change
  	add_index :users, :email, unique: true #in the users table, add an index to the email column 
  end
end
