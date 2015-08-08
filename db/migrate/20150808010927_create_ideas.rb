class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|

      t.timestamps null: false
    end
  end
end
