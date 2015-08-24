class CreateFounders < ActiveRecord::Migration
  def change
    create_table :founders do |t|
      t.references :user, :idea
      t.string :role
      t.timestamps null: false
    end
  end
end
