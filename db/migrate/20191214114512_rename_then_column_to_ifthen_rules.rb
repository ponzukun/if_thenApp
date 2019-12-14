class RenameThenColumnToIfthenRules < ActiveRecord::Migration[5.2]
  def change
    rename_column :ifthen_rules, :then, :then_content
  end
end
