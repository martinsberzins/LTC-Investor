class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :name
      t.string :ticker
      t.text :description
      t.string :region
      t.boolean :active

      t.timestamps
    end
  end
end
