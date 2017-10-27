class AddSummaryToTeachers < ActiveRecord::Migration[5.1]
  def change
    add_column :teachers, :summary, :string
  end
end
