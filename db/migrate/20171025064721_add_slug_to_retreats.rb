class AddSlugToRetreats < ActiveRecord::Migration[5.1]
  def change
    add_column :retreats, :slug, :string
    add_index :retreats, :slug, unique: true
  end
end
