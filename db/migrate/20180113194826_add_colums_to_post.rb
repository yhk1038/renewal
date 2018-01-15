class AddColumsToPost < ActiveRecord::Migration[5.1]
  def change
    add_reference :posts, :theme, foreign_key: true
    add_column :posts, :content_type, :string
    add_column :posts, :runtime, :string
    add_column :posts, :title, :string
    add_column :posts, :thumbnail_img, :string
  end
end
