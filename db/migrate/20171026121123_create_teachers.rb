class CreateTeachers < ActiveRecord::Migration[5.1]
  def change
    create_table :teachers do |t|
      t.string :name
      t.text :summary
      t.text :biography
      t.text :main_image
      t.text :thumb_nail

      t.timestamps
    end
  end
end
