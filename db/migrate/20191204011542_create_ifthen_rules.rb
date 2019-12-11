class CreateIfthenRules < ActiveRecord::Migration[5.2]
  def change
    create_table :ifthen_rules do |t|
      t.text :if
      t.text :then
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :ifthen_rules, [:user_id, :created_at]
  end
end
