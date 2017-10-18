class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :thumb_nail
      t.string :main_image
      t.decimal :price

      t.timestamps
    end
  end
end
