class AddStripeCustomerIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_plan,        :string
    add_column :users, :stripe_customer_id, :string
    add_index  :users, :stripe_customer_id
  end
end
