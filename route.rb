class Route
  attr_reader :first_station, :last_station
  include InstanceCounter
  
  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @intermediate_stations = []
    register_instance
    validate!
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

  def valid?
    validate!
  rescue
    false
  end
  
  private

  def validate!
    raise "First and last station can't be non-Station class" if first_station.empty? or last_station.empty?
    true
  end

end
