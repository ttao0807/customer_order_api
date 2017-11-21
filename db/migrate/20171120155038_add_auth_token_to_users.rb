class AddAuthTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :auth_token, :string, default: ""
    add_index :customers, :auth_token, unique: true 
  end
end
