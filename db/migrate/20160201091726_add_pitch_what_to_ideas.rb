class AddPitchWhatToIdeas < ActiveRecord::Migration
  def change
    add_column :ideas, :pitch_what, :text
  end
end
