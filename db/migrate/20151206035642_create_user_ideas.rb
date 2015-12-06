class CreateUserIdeas < ActiveRecord::Migration
  def change
    create_table :user_ideas do |t|
      t.references :user
      t.references :idea
      t.string     :access_level, null: false, default: UserIdea::ACCESS_READ

      t.timestamps null: false
    end
  end
end
