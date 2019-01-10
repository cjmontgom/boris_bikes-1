require_relative 'bike'

class DockingStation
  attr_reader :docked_bikes

  def initialize
    @docked_bikes = []
  end

  def release_bike
    fail "There are no bikes" if no_bikes?
    @docked_bikes.pop
  end

  def dock(bike)
    fail "Station is full" if full?
    @docked_bikes.push(bike)
  end

  private

  def full?
    @docked_bikes.length >= 20
  end

  def no_bikes?
    @docked_bikes.empty?
  end
end
