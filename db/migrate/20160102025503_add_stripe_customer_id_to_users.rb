class AddStripeCustomerIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :plan,               :string, null: false, default: Plan::Free.id
    add_column :users, :stripe_customer_id, :string
    add_index  :users, :stripe_customer_id
  end
end
