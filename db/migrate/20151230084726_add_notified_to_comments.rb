class AddNotifiedToComments < ActiveRecord::Migration
  def change
    add_column :comments, :notified, :boolean, null: false, default: false
  end
end
