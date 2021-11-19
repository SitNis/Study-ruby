class Station
  attr_reader :trains
  attr_accessor :name, :instances
  include CompanyName
  include InstanceCounter
   

  
  def self.all
    @@instances
  end

  def initialize(name)
    @name = name
    @trains = []
    register_instance
    validate!
  end

  def add_train(train_name)
    @trains << train_name
  end

  def send_train(train)
    @trains.delete(train)
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