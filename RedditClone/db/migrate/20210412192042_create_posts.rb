class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title, nil: false
      t.string :url
      t.string :content
      t.integer :sub_id
      t.integer :author_id
    end

    add_index :posts, :sub_id
    add_index :posts, :author_id
  end
end
