class CreateLocation < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.integer :site_id
      t.string :name
      t.st_point :coordinates, geographic: true
      t.decimal :latitude,    :precision => 8, :scale => 6
      t.decimal :longitude,   :precision => 8, :scale => 6
      t.timestamps

    end
    add_index :locations, :site_id, unique: true
  end
end
