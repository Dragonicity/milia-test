class CreateBlogs < ActiveRecord::Migration[5.1]
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :body
      t.string :main_image
      t.string :thumb_nail
      t.integer :status, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
