require_relative 'Station'
require_relative 'Route'
require_relative 'Train'
require_relative 'Train_cargo'
require_relative 'Train_passenger'
require_relative 'Wagon'
require_relative 'Wagon_cargo'
require_relative 'Wagon_passenger'


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
      puts "Что создать?\n
      1 - станцию\n
      2 - поезд\n
      3 - маршрут\n
      4 - вагон\n"
      button = gets.chomp()
        case button
        when "1"
          puts "Введи название станции"
          station_name = gets.chomp()
          if station_name.length != 0
            station = Station.new(station_name)
            @stations.push(station)
          end
          menu
        when "2"
          puts "Введи номер поезда и тип(Cargo или Passenger)"
          train_serial_number = gets.chomp()
          train_type = gets.chomp()
          if train_type == "Cargo"
            new_train = Train_cargo.new(train_serial_number)
            @trains.push(new_train)
            menu
          elsif train_type == "Passenger"
            new_train = Train_passenger.new(train_serial_number)
            @trains.push(new_train)
            menu
          end
        when "3"
          puts "Введи название начальной и конечной станций из списка\n
            #{self.stations}"
          first_station_name = gets.chomp()
          last_station_name = gets.chomp()
          route = Route.new(self.stations.select{|station| station.name == first_station_name}, self.stations.select{|station| station.name == last_station_name})
          @routes.push(route)
          menu
        when "4"
          puts "Введи тип вагона(Cargo или Passenger)"
          wagon_type = gets.chomp()
          if wagon_type == "Cargo"
            new_wagon = Wagon_cargo.new()
          elsif wagon_type == "Passenger"
            new_wagon = Wagon_passenger.new()
          end
          @wagons.push(new_wagon)
          menu                            
        end
    when "2"
      puts "\n
        1 - взаимодействовать с поездом\n
        2 - взаимодействовать с маршрутом\n"
      button = gets.chomp()
      case button
      when "1"
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
            puts "Какой вагон прикрепить?(Введи порядковый номер до #{self.wagons.length})\n
              #{self.wagons}"
            wagon_id = gets.chomp().to_i
            self.trains[train_id-1].add_wagon(self.wagons[wagon_id-1])
            menu
          when "2"
            puts "Какой вагон отцепить?(Введи порядковый номер до #{self.trains[train_id-1].wagons.length})\n
              #{self.trains[train_id-1].wagons}"
            wagon_id = gets.chomp().to_i
            self.trains[train_id-1].delete_wagon(self.trains[train_id-1].wagons[wagon_id-1])
            menu
          when "3"
            puts "Какой маршрут назначить?(Введи порядковый номер до #{self.routes.length})\n
              #{self.routes}"
            route_id = gets.chomp().to_i
            self.trains[train_id-1].get_route(self.routes[route_id-1])
            menu
          when "4"
            puts "Поехать вперед(1) или назад(2)?"
            move = gets.chomp()
            if move == "1"
              self.trains[train_id-1].move_forward
            elsif move == "2"
              self.trains[train_id-1].move_back
            end
            menu
          end
      when "2"
        puts "С каким маршрутом взаимодействовать?(Порядковый номер до #{self.routes.length}\n
          #{self.routes})"
        route_id = gets.chomp().to_i
        puts "\n
          1 - добавить станцию\n
          2 - убрать станцию\n"
        button = gets.chomp()
        case button
        when "1"
          puts "Какую станцию добавить?\n
          #{self.stations}"
          puts "Введи имя станции"
          station_name = gets.chomp()
          self.routes[route_id-1].add_internediate_station(self.stations.select{|station| station.name == station_name})
          menu
        when "2"
          puts "Какую станцию убрать с маршрута?(Введи имя станции)\n
            #{self.routes[route_id-1].stations}"
          station_name = gets.chomp()
          self.routes[route_id-1].delete_internediate_station(self.stations.select{|station| station.name == station_name})
          menu
        end
      end
    when "3"
      puts "\n
        1 - список станций\n
        2 - список поездов на станции\n"
        button = gets.chomp()
        case button
        when "1"
          puts self.stations
          menu
        when "2"
          puts "Введи название станции \n
            #{self.stations}"
          station_name = gets.chomp()
          station = self.stations.select{ |station| station.name == station_name }
          puts station[0].trains.name
          menu
        end
    end
  end
end