class Wagon
  attr_reader :type
  include CompanyName
  def initialize(type)
    @type = type
  end
  
  protected
  def validate!
  	raise "Type can't be null" if type.empty?
  end
end
