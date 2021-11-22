class Station
  attr_reader :trains
  attr_reader :name, :instances, :stations
  include CompanyName
  include InstanceCounter
  extend Accessor
  include Validate
  attr_accessor_with_history :a, :b
  strong_attr_accessor :c,String
  @@stations = []
  
  def self.all
    @@stations
  end

  validate :name, :presence


  def initialize(name)
    @name = name
    @trains = []
    register_instance
    validate!
    @@stations.push(self)
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

  # def valid?
  #   validate!
  # rescue
  #   false
  # end

  private

  # def validate!
  #   raise "Station name can't be nil" if name.empty?
  #   true
  # end

  # Пользователь не может посмотреть количество поездов определенного
  def show_trains_by(type)
    @trains.select { | train | train.type == type}
  end
  
end