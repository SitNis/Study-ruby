class Wagon_passenger < Wagon
  attr_reader :places, :taken_places

  def initialize(places)
    @type = "Passenger"
    @places = places
    @taken_places = 0
  end

  def take_place
    if !places.zero?
      @places -= 1
      @taken_places += 1
    end
  end

end
