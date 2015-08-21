class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, :idea
      t.text :body
      t.timestamps null: false
    end
  end
end
