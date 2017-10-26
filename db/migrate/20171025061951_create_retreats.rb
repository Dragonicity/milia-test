class CreateRetreats < ActiveRecord::Migration[5.1]
  def change
    create_table :retreats do |t|
      t.string :name
      t.text :body
      t.date :start_date
      t.date :end_date
      t.string :teachers
      t.string :program_link
      t.string :registration_link
      t.string :thumb_nail
      t.string :main_image
      t.string :rbg_id

      t.timestamps
    end
  end
end
