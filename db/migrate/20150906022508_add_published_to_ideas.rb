class AddPublishedToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :published, :boolean, default: false
  end
end
