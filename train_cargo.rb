class TrainCargo < Train
  validate :serial_number, :format, REGEXP
  def initialize(serial_number, type = "Cargo")
    super
  end
  
end