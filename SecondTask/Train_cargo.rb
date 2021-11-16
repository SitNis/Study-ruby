class Train_cargo < Train

  def initialize(serial_number, type = "Cargo")
    super
  end

  def add_wagon(wagon)
    return "Not a cargo wagon" if wagon.type != "Cargo"
    super
  end

end