class AddSubtitleToBlog < ActiveRecord::Migration[5.1]
  def change
    add_column :blogs, :subtitle, :string
  end
end
