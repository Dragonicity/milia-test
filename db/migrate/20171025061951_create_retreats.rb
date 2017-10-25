class CreateRetreats < ActiveRecord::Migration[5.1]
  def change
    create_table :retreats do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.string :teachers
      t.string :program_link
      t.string :registration_link
      t.string :thumb_nail
      t.string :main_image
      t.integer :rbg_id

      t.timestamps
    end
  end
end
