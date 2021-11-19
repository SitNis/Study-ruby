class Train
  attr_reader :type, :wagons, :serial_number
  attr_writer :type

  @@all_trains = []

  include InstanceCounter

  def self.find(serial_number)
    if @@all_trains.select { |train| train.serial_number == serial_number }
    else nil
    end
  end

  def initialize(serial_number, type)
    @serial_number = serial_number
    @type = type
    @speed = 0
    @wagons = []
    @@all_trains.push(self)
    register_instance
    validate!
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

  def valid?
    validate!
  rescue RuntimeError => e
    puts e.message
  end


  #Вынес данные методы в Protected, т.к. пользователь не может вызывать эти методы, но дочерние классы их наследуют
  protected

  REGEXP = /^\w{3}-?\w{2}$/

  def validate!
    raise "Type can't be nil" if type.empty?
    raise "Incorrect serial number" if serial_number !~ REGEXP
    true
  end

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