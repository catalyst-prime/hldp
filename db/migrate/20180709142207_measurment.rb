class Measurment < ActiveRecord::Migration[5.2]
  def change
    create_table :measurements do |t|
      t.integer :site
      t.string :lab_id
      t.string :name
      t.string  :result
      t.string  :units
      t.integer  :month
      t.integer  :day
      t.integer  :year
      t.timestamps

    end
    add_index :measurements, :lab_id

  end
end
