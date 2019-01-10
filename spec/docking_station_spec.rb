require 'docking_station'

describe DockingStation do

  let(:bike) {double :bike}

  it { is_expected.to respond_to :release_bike }

  it 'expects release_bike to return a bike when a (working) bike is at the station' do
    allow(bike).to receive(:broken?).and_return(false)
    station_with_bike = DockingStation.new
    bike_at_station = bike
    station_with_bike.dock(bike_at_station)
    expect(station_with_bike.release_bike).to eq(bike_at_station)
    #can't call release bike on a station where we've docked a non-bike,
    #because the release bike method checks to see if the docked thing is broken? - which
    #id defined on the Bike class.
  end

  it { is_expected.to respond_to(:dock).with(1).argument }

  it 'expects bike attribute of station to equal docked bike' do
    unique_bike = bike
    subject.dock(unique_bike)
    expect(subject.docked_bikes).to include(unique_bike)
  end

  it 'expects new docking station with no bikes to raise error when releasing a bike' do
    expect { DockingStation.new.release_bike }.to raise_error("There are no bikes")
  end

  it 'will raise an error if attempting to dock a bike in a full station and not raise error if docking fewer bikes' do
    occupied_dock = DockingStation.new()
    expect { DockingStation::DEFAULT_CAPACITY.times { |i| occupied_dock.dock(bike) } }.to_not raise_error
    expect { occupied_dock.dock("21st Bike") }.to raise_error("Station is full")
  end

  it "will raise error user tries to release a broken bike" do
    allow(bike).to receive(:broken?).and_return(true)
    allow(bike).to receive(:report_broken)
    broken_bike = bike
    broken_bike.report_broken
    subject.dock(broken_bike)
    expect { subject.release_bike }.to raise_error "Bike is broken"
    #can't report broken on a non-bike
  end


end
