class Wagon
  attr_reader :type
  include CompanyName
  def initialize(type)
    @type = type
  end
  
end
