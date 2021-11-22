class TrainPassenger < Train
  validate :serial_number, :format, REGEXP
  def initialize(serial_number, type = "Passenger")
    super
  end

end