class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: User::ROLE_USER, null: false
  end
end
