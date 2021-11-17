class Route
  attr_reader :first_station, :last_station

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @intermediate_stations = []
  end

  def add_internediate_station(station_name)
    @intermediate_stations.push(station_name)
  end

  def delete_internediate_station(station)
    @intermediate_stations.delete(station)
  end

  def stations
    [@first_station] + @intermediate_stations + [@last_station]
  end

end
