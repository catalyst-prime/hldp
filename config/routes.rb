Rails.application.routes.draw do
  get 'lake_depth/get'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root to: 'measurements#index'
    get 'tables' => 'measurements#showTables'
    get 'documentation' => 'measurements#showDoc'
    get 'phosphorus' => 'measurements#showPhosphorus'
    get 'nitrate' => 'measurements#showNitrate'
    get 'nitrite' => 'measurements#showNitrite'
    get 'ph' => 'measurements#showpH'
    get 'oxygen' => 'measurements#showOxygen'
    get 'tds' => 'measurements#showTDS'
    get 'conductivity' => 'measurements#showConductivity'
    get 'beachPlateCount' => 'measurements#showBPC'
    get 'ecoli' => 'measurements#showeColi'
    get 'airTemp' => 'measurements#showAir'
    get 'waterTemp' => 'measurements#showWater'
    get 'depth' => 'lake_depths#showDepth'
end
