class AddUserIdeaIndexes < ActiveRecord::Migration
  def change
    add_index :user_ideas, :user_id
    add_index :user_ideas, :idea_id
    add_index :user_ideas, [:user_id, :idea_id], unique: true
  end
end
