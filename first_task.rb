class Station
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train_name)
    @trains << train_name
  end

  def show_trains_by(type)
    return @trains.select { | train | train.type == type}
  end

  def send_train(train)
    @trains.delete(train)
  end
end

class Route
  attr_accessor :stations

  def initialize(first_station, last_station)
    @first_station = first_station
    @last_station = last_station
    @intermediate_stations = []
    @stations = [@first_station] + @intermediate_stations + [@last_station]
  end

  def add_internediate_station(station_name)
    @intermediate_stations.push(station_name)
    self.stations = [@first_station] + @intermediate_stations + [@last_station]
  end

  def delete_internediate_station(station)
    @intermediate_stations.delete(station)
    self.stations = [@first_station] + @intermediate_stations + [@last_station]
  end
end

class Train
  attr_accessor :speed, :number_of_van
  attr_reader :type

  def initialize(speed = 0,serial_number, type, number_of_van)
    @serial_number = serial_number
    @type = type
    @number_of_van = number_of_van
    @speed = speed
  end

  def go(speed)
    self.speed = speed
  end

  def stop
    self.speed = 0
  end

  def add_van
    if self.speed == 0
      self.number_of_van += 1
    end
  end

  def delete_van
    if self.speed == 0
      self.number_of_van -=1
    end
  end

  def get_route(route_obj)
    @route = route_obj
    @current_station = @route.stations[0]
    @current_station_id = 0
  end

  def move_forward
    if @route.stations.last != @current_station
      @current_station_id += 1
      @current_station = @route.stations[@current_station_id]
    end
  end

  def move_back
    if @current_station_id != 0
      @current_station_id -= 1
      @current_station = @route.stations[@current_station_id]
    end
  end

  def previous_station
    if @route and @route.stations[@current_station_id - 1] != @route.stations.last
      previous_station = @route.stations[@current_station_id - 1]
    end
  end

  def next_station
    if @route and @route.stations[@current_station_id + 1] != @route.stations[0]
      previous_station = @route.stations[@current_station_id + 1]
    end
  end

  def current_station
    if @route
      @current_station
    end
  end

end