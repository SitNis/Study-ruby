class Train_passenger < Train

  def initialize(serial_number, type = "Passenger")
    super
  end

  def add_wagon(wagon)
    return "Not a Passenger wagon" if wagon.type != "Passenger"
    super
  end

end