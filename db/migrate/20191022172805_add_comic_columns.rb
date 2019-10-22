class AddComicColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :comics, :description, :text
  end
end
