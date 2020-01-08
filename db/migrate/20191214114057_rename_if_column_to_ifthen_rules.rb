class RenameIfColumnToIfthenRules < ActiveRecord::Migration[5.2]
  def change
    rename_column :ifthen_rules, :if, :if_content
  end
end
