class ChannelsIdeas < ActiveRecord::Migration
  def change
    create_table :channels_ideas, id: false do |t|
      t.references :channel, :idea
    end
  end
end
