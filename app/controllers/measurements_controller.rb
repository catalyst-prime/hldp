class MeasurementsController < ApplicationController
  def showTables
    # render tables
  end

  def index
    # render main menu of options, all of which are links.  This is the home page of the app
  end

  def showDoc
    #render the pdf file with the latest project report
  end

  def showPhosphorus
    @data = Measurement.phosphorus
    # render tables
  end
  def showNitrate
    @data = Measurement.nitrate
    # render tables
  end
  def showNitrite
    @data = Measurement.nitrite
    # render tables
  end
  def showpH
    @data = Measurement.ph
    # render tables
  end
  def showOxygen
    @data = Measurement.oxygen
    # render tables
  end
  def showTDS
    @data = Measurement.tds
    # render tables
  end
  def showConductivity
    @data = Measurement.conductivity
    # render tables
  end
  def showBPC
    @data = Measurement.bpc
    # render tables
  end
  def showeColi
    @data = Measurement.ecoli
    # render tables
  end
  def showAir
    @data = Measurement.air_temp
    # render tables
  end
  def showWater
    @data = Measurement.water_temp
    # render tables
  end
end
