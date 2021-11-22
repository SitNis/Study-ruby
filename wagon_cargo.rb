class WagonCargo < Wagon
  attr_reader :volume, :taken_volume

  def initialize(volume)
    @type = "Cargo"
    @volume = volume
    @taken_volume = 0
  end
  
  def take_volume(volume_size)
    if volume_size < volume
      @volume -= volume_size
      @taken_volume += volume_size
    end
  end

end
