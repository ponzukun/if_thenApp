class AddPictureToIfthenRules < ActiveRecord::Migration[5.2]
  def change
    add_column :ifthen_rules, :picture, :string
  end
end
