class AddSlugToTeacher < ActiveRecord::Migration[5.1]
  def change
    add_column :teachers, :slug, :string
    add_index :teachers, :slug, unique: true
  end
end
