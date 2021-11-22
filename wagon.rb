class Wagon
  attr_reader :type
  include CompanyName
  include Validate
  
  validate :type, :presence

  def initialize(type)
    @type = type
  end
  
  protected
  # def validate!
  # 	raise "Type can't be null" if type.empty?
  # end

end
