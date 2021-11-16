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
    @trains.select { | train | train.type == type}
  end

  def send_train(train)
    @trains.delete(train)
  end
  
  
end

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

  def get_route(route)
    @route = route
    @current_station_id = 0
    @route.stations[0].add_train(self)
  end

  def move_forward
    return unless next_station
    @route.stations[@current_station_id].send_train(self)
    @current_station_id += 1
    @route.stations[@current_station_id].add_train(self)
  end

  def move_back
    return unless previous_station
    @route.stations[@current_station_id].send_train(self)
    @current_station_id -= 1
    @route.stations[@current_station_id].add_train(self)
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
      @route.stations[@current_station_id]
    end
  end

end