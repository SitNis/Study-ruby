class Station
  attr_reader :trains
  attr_reader :name
  def initialize(name)
    @name = name
    @trains = []
  end

  def add_train(train_name)
    @trains << train_name
  end

  def send_train(train)
    @trains.delete(train)
  end

  private
  # Пользователь не может посмотреть количество поездов определенного
  def show_trains_by(type)
    @trains.select { | train | train.type == type}
  end
  
end