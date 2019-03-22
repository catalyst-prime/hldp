class AddCollectionDateAndSiteNameToMeasurement < ActiveRecord::Migration[5.2]
  def change
    add_column  :measurements,  :site_name, :string
    add_column  :measurements,  :collection_date, :date

  end
end
