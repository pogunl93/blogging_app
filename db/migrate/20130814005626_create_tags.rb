class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :tag_id
      t.string :tag_description

      t.timestamps
    end
  end
end
