class CreateFounderPositions < ActiveRecord::Migration
  def change
    create_table :founder_positions do |t|
      t.references :founder, :idea
      t.string :position
      t.timestamps null: false
    end
  end
end
