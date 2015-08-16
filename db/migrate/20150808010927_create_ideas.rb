class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.string :name
      t.text :problem
      t.text :idea
      t.text :mvp
      t.timestamps null: false
    end
  end
end
