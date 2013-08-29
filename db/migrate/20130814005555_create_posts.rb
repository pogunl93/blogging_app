class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :post_name
      t.string :post_description
      t.text :post_text
      t.integer :user_id

      t.timestamps
    end
  end
end
