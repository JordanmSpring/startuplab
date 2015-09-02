class CreateCrowdfundingOptions < ActiveRecord::Migration
  def change
    create_table :crowdfunding_options do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end
