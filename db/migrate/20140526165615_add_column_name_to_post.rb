class AddColumnNameToPost < ActiveRecord::Migration
  def change
    add_column :posts, :website, :string
  end
end
