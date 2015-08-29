class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.references :user
      t.string :name
      t.text :problem
      t.text :problem_detail
      t.text :idea
      t.string :company
      t.string :mvp_url
      t.string :mvp_stage
      t.string :target_customer
      t.text :target_customer_reason
      t.text :costs
      t.text :revenue
      t.text :pitch_why
      t.text :pitch_how
      t.text :timing_why
      t.text :timing_description
      t.timestamps null: false
    end
  end
end
