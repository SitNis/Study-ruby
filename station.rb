class Station
  attr_reader :trains
  attr_accessor :name, :instances, :stations
  include CompanyName
  include InstanceCounter
   
  @@stations = []
  
  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations.push(self)
    register_instance
    validate!
  end

  def add_train(train_name)
    @trains << train_name
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_on_station
    self.trains.each do |train|
      yield(train)
    end
  end

  def valid?
    validate!
  rescue
    false
  end

  private

  def validate!
    raise "Station name can't be nil" if name.empty?
    true
  end

  # Пользователь не может посмотреть количество поездов определенного
  def show_trains_by(type)
    @trains.select { | train | train.type == type}
  end
  
end