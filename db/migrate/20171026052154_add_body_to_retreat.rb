class AddBodyToRetreat < ActiveRecord::Migration[5.1]
  def change
     add_column :retreats, :body, :text
  end
end
