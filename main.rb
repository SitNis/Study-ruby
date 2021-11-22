require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'train_cargo'
require_relative 'train_passenger'
require_relative 'wagon'
require_relative 'wagon_cargo'
require_relative 'wagon_passenger'


class Main
  attr_reader :stations, :trains, :routes, :wagons
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end

  def menu
    puts "\n
      1 - чтобы создать новый объект\n
      2 - чтобы взаимодействовать с объектом\n
      3 - чтобы посмотреть список объектов\n
      0 - чтобы закончить работу\n"
    button = gets.chomp()
    case button
    when "1"
      create_menu
    when "2"
      actions_with_objects
    when "3"
      list_menu
    end
  end

  private

  def new_station
    puts "Введи название станции"
    station_name = gets.chomp()
    if station_name.length != 0
      station = Station.new(station_name)
      @stations.push(station)
    end
    menu
  end

  def new_train
    puts "Введи номер поезда и тип(Cargo или Passenger)"
    train_serial_number = gets.chomp()
    train_type = gets.chomp()
    if train_type == "Cargo"
      new_train = TrainCargo.new(train_serial_number)
      new_train.valid?
      @trains.push(new_train)
      puts "#{new_train} создан!"
      menu
    elsif train_type == "Passenger"
      new_train = TrainPassenger.new(train_serial_number)
      new_train.valid?
      @trains.push(new_train)
      menu
    end
  end

  def new_route
    puts "Введи название начальной и конечной станций из списка\n
      #{self.stations}"
    first_station_name = gets.chomp()
    last_station_name = gets.chomp()
    route = Route.new(self.stations.select{|station| station.name == first_station_name}[0], self.stations.select{|station| station.name == last_station_name}[0])
    @routes.push(route)
    menu
  end

  def new_wagon
    puts "Введи тип вагона(Cargo или Passenger)"
    wagon_type = gets.chomp()
    if wagon_type == "Cargo"
      puts "Введи максимальный объем груза"
      volume = gets.chomp().to_i
      new_wagon = WagonCargo.new(volume)
    elsif wagon_type == "Passenger"
      puts "Введи количетсво мест"
      places = gets.chomp().to_i
      new_wagon = WagonPassenger.new(places)
    end
    @wagons.push(new_wagon)
    menu       
  end

  def create_menu
    puts "Что создать?\n
      1 - станцию\n
      2 - поезд\n
      3 - маршрут\n
      4 - вагон\n"
    button = gets.chomp()
    case button
    when "1"
      new_station
    when "2"
      begin
        new_train
      rescue Exception => e
        puts "#{e.inspect}"
      retry
      end
    when "3"
      new_route
    when "4"
      new_wagon            
    end
  end

  def hook_wagon(train_id)
    puts "Какой вагон прикрепить?(Введи порядковый номер до #{self.wagons.length})\n
      #{self.wagons}"
    wagon_id = gets.chomp().to_i
    train_id = train_id
    self.trains[train_id-1].add_wagon(self.wagons[wagon_id-1])
    menu
  end

  def unhook_wagon(train_id)
    puts "Какой вагон отцепить?(Введи порядковый номер до #{self.trains[train_id-1].wagons.length})\n
      #{self.trains[train_id-1].wagons}"
    wagon_id = gets.chomp().to_i
    train_id = train_id
    self.trains[train_id-1].delete_wagon(self.trains[train_id-1].wagons[wagon_id-1])
    menu
  end

  def route_for_train(train_id)
    puts "Какой маршрут назначить?(Введи порядковый номер до #{self.routes.length})\n
      #{self.routes}"
    route_id = gets.chomp().to_i
    train_id = train_id
    self.trains[train_id-1].get_route(self.routes[route_id-1])
    menu
  end

  def move_train(train_id)
    puts "Поехать вперед(1) или назад(2)?"
    move = gets.chomp()
    train_id = train_id
    if move == "1"
      self.trains[train_id-1].move_forward
    elsif move == "2"
      self.trains[train_id-1].move_back
    end
    menu
  end

  def train_menu
    puts "С каким поездом взаимодействовать?(Введи порядковый номер до #{self.trains.length})\n
      #{self.trains}"
    train_id = gets.chomp().to_i
    puts "\n
      1 - прикрепить вагон\n
      2 - открепить вагон\n
      3 - назначить маршрут\n
      4 - перемещаться\n"
    button = gets.chomp()
    case button
    when "1"
      hook_wagon(train_id)
    when "2"
      unhook_wagon(train_id)
    when "3"
      route_for_train(train_id)
    when "4"
      move_train(train_id)
    end
  end

  def new_station_in_route(route_id)
    puts "Какую станцию добавить?\n
      #{self.stations}"
    puts "Введи имя станции"
    station_name = gets.chomp()
    route_id = route_id
    self.routes[route_id-1].add_internediate_station(self.stations.select{|station| station.name == station_name})
    menu
  end

  def delete_station_in_route(route_id)
    puts "Какую станцию убрать с маршрута?(Введи имя станции)\n
      #{self.routes[route_id-1].stations}"
    station_name = gets.chomp()
    route_id = route_id
    self.routes[route_id-1].delete_internediate_station(self.stations.select{|station| station.name == station_name})
    menu
  end

  def route_menu
    puts "С каким маршрутом взаимодействовать?(Порядковый номер до #{self.routes.length}\n
      #{self.routes})"
    route_id = gets.chomp().to_i
    puts "\n
      1 - добавить станцию\n
      2 - убрать станцию\n"
    button = gets.chomp()
    case button
    when "1"
      new_station_in_route(route_id)
    when "2"
      delete_station_in_route(route_id)
    end
  end

  def take_place
    puts "В каком вагоне занять место?(Порядковый номер от 1 до #{@wagons.length}\n
    #{@wagons}"
    wagon_id = gets.chomp().to_i
    if @wagons[wagon_id-1].type == "Passenger"
      @wagons[wagon_id-1].take_place
    end
    menu
  end

  def take_volume
    puts "В каком вагоне занять объем?(Порядковый номер от 1 до #{@wagons.length}\n
    #{@wagons}"
    wagon_id = gets.chomp().to_i
    if @wagons[wagon_id-1].type == "Cargo"
      puts "Сколько занять?"
      volume = gets.chomp().to_i
      @wagons[wagon_id-1].take_volume(volume)
    end 
    menu
  end

  def wagon_menu
    puts "\n
      1 - Занять место в вагоне\n
      2 - Заполнить объем вагона\n"
    button = gets.chomp()
    case  button
    when "1"
      take_place
    when "2"
      take_volume
    end
  end


  def actions_with_objects
    puts "\n
      1 - взаимодействовать с поездом\n
      2 - взаимодействовать с маршрутом\n
      3 - взаимодействовать с вагонами\n"
    button = gets.chomp()
    case button
    when "1"
      train_menu
    when "2"
      route_menu
    when "3"
      wagon_menu
    end
  end

  def stations_list
    puts self.stations
    menu
  end

  def list_menu
    puts "\n
      1 - список станций\n
      2 - список поездов на станции\n
      3 - список вагонов поезда\n"
    button = gets.chomp()
    case button
    when "1"
      stations_list
    when "2"
      trains_on_station_list
    when "3"
      train_wagons
    end
  end

  def trains_on_station_list
    puts "Введи название станции \n
      #{self.stations}"
    station_name = gets.chomp()
    Station.all.each do |station|
      station.trains_on_station { |train| puts train if train.current_station[0].name == station_name }
    end
    menu
  end

  def train_wagons
    puts "Вагоны какого поезда вывести?(Порядковый номер до #{self.trains.length}\n
     #{self.trains}"
    train_id = gets.chomp().to_i
    self.trains.each do |train|
      if !trains[train_id-1].wagons.empty?
        train.train_wagons { |wagon| puts wagon }
      end
    end
    menu
  end

end
