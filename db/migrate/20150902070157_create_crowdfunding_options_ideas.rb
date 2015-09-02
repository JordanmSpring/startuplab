class CreateCrowdfundingOptionsIdeas < ActiveRecord::Migration
  def change
    create_table :crowdfunding_options_ideas, id: false do |t|
      t.references :crowdfunding_option, :idea
    end
  end
end
