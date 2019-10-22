class CreateMarvelTables < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.string :name
      t.text :description
    end
    create_table :comics do |t|
      t.string :title
      t.integer :issue_number
      t.integer :page_count
      t.float :price
    end
    create_table :creators do |t|
      t.string :full_name
    end
    create_table :character_comics do |t|
      t.integer :character_id
      t.integer :comic_id
    end
    create_table :character_creators do |t|
      t.integer :character_id
      t.integer :creator_id
    end
    create_table :comic_creators do |t|
      t.integer :comic_id
      t.integer :creator_id
    end
  end
end
