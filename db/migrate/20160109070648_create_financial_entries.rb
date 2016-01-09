class CreateFinancialEntries < ActiveRecord::Migration
  def change
    create_table :financial_entries do |t|
      t.references :idea
      t.string     :group, null: false
      t.string     :name,  null: false
      t.integer    :value, null: false
      t.timestamps null: false
    end

    add_index :financial_entries, :idea_id
    add_index :financial_entries, [:idea_id, :group]
  end
end
