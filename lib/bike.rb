class Bike
attr_accessor :status

  def initialize
    @status = 'working'
  end

  def working?
    if bike.status == 'working'
      true
    elsif bike.status != 'working'
      false
    end
  end
end
