class Measurement < ApplicationRecord
require 'csv'

scope :air_temp, -> { where(name: 'Air Temperature').order('site_name','month') }
scope :phosphorus, -> { where(name: 'Phosphorus') }
scope :nitrate, -> { where(name: 'Nitrogen (Nitrate)') }
scope :nitrite, -> { where(name: 'Nitrogen (Nitrite)') }
scope :bpc, -> { where(name: 'Beach Plate Count; MPN') }
scope :ecoli, -> { where(name: 'Beach Plate Count; e-coli') }
scope :ph, -> { where(name: 'pH') }
scope :oxygen, -> { where(name: 'Dissolved Oxygen') }
scope :tds, -> { where(name: 'Total Dissolved Solids') }
scope :water_temp, -> { where(name: 'Water Temperature').order('site_name','month') }
scope :conductivity, -> { where(name: 'Conductivity') }
#May want scopes for site names as well, but hold off for now; above suitable for tables and graphs...

  def self.import(file_path)
    # WARN -- this is brute force, no data checks, no duplication checks!!!
    # Measurement.import('/Users/gryfon1/Desktop/ActiveCatalyst/Adderstone/HLDataPortalAPI/Data files/round1.csv')
    # Measurement.import('/Users/gryfon1/Desktop/ActiveCatalyst/Adderstone/HLDataPortalAPI/Data files/round2.csv')
    # Measurement.import('/Users/gryfon1/Desktop/ActiveCatalyst/Adderstone/HLDataPortalAPI/Data files/round3.csv')
    # Measurement.import('/Users/gryfon1/Desktop/ActiveCatalyst/Adderstone/HLDataPortalAPI/Data files/round4.csv')
    # WARN -- make sure the header fields have been 'sanitized' -- comma separated, no leading or trailing spaces
    # internal spaces are oky.  Delete units for conductivity and the 2 temperature measures

  CSV.foreach(file_path, headers: true) do |row|
      data_hash = row.to_hash
      measures = ["Phosphorus", "Nitrogen (Nitrate)", "Nitrogen (Nitrite)","Beach Plate Count; MPN","Beach Plate Count; e-coli","pH","Dissolved Oxygen","Total Dissolved Solids","Water Temperature","Air Temperature","Conductivity"]
      measures.each do |measureName|
        if ["Phosphorus", "Nitrogen (Nitrate)", "Nitrogen (Nitrite)", "Dissolved Oxygen"].include? measureName
          un = "mg/L"
        elsif measureName == 'pH'
          un = 'pH'
        elsif measureName == "Total Dissolved Solids"
          un = 'percent'
        elsif ["Water Temperature","Air Temperature"].include? measureName
          un = 'degrees Centigrade'
        elsif ["Beach Plate Count; MPN","Beach Plate Count; e-coli"].include? measureName
          un = 'colonies/100mL'
        elsif measureName == "Conductivity"
          un = 'uS/cM'  #microSiemens/centimeter
        else
          un = ""
        end
        #WARN -- fragile, assumes dates is parsable from lab number as per round1 and round 2 data
        begin
          date = Date.parse(data_hash["Lab Number"])
          month = date.month.to_i
          date.year < 1000 ? year = 2000 + date.year.to_i : year = date.year.to_i
          day = date.day.to_i
        rescue => e
          p ("uncaught #{e} exception while parsing lab number for date")
          p ("Stack trace: #{e.backtrace.map {|l| "  #{l}\n"}.join}")
        end
        create(lab_id: data_hash["Lab Number"],
               site: data_hash["Site"],
               name: measureName,
               result: data_hash[measureName],
               units: un,
               month: month,
               day: day,
               year: year,
               collection_date: Date.parse(data_hash["Lab Number"])
               )
        #WARN -- site name will need to be manually updated!  Or code needs to have additions...
      end
    end
  end

  def collection_date
    return Date.new(self.year, self.month, self.day)
  end
end