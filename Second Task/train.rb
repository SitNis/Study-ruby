class Train
  attr_reader :type, :wagons

  def initialize(serial_number, type)
    @serial_number = serial_number
    @type = type
    @speed = 0
    @wagons = []
  end

  def add_wagon(wagon)
    if self.speed == 0 and wagon.type == self.type
      @wagons.push(wagon)
    end
  end

  def delete_wagon(wagon)
    if self.speed == 0
      @wagons.delete(wagon)
    end
  end

  def get_route(route)
    @route = route
    @current_station_id = 0
    @route.stations[0][0].add_train(self)
  end

  def move_forward
    return unless next_station
    @route.stations[@current_station_id][0].send_train(self)
    @current_station_id += 1
    @route.stations[@current_station_id][0].add_train(self)
  end

  def move_back
    return unless previous_station
    @route.stations[@current_station_id][0].send_train(self)
    @current_station_id -= 1
    @route.stations[@current_station_id][0].add_train(self)
  end


  #Вынес данные методы в Protected, т.к. пользователь не может вызывать эти методы, но дочерние классы их наследуют
  protected

  attr_accessor :speed

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

  def go(speed)
    self.speed = speed
  end

  def stop
    self.speed = 0
  end

end