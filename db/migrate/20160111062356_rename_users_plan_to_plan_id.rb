class RenameUsersPlanToPlanId < ActiveRecord::Migration
  def change
    rename_column :users, :plan, :plan_id
  end
end
