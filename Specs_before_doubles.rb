require 'airport'
require 'plane'

describe Airport do

  it 'allows a plane to land' do
    plane1 = Plane.new
    subject.land_plane(plane1)
    expect(subject.terminal).to eq [plane1]
  end

  it 'allows multiple planes to land' do
    plane1 = Plane.new
    plane2 = Plane.new
    subject.land_plane(plane1)
    subject.land_plane(plane2)
    expect(subject.terminal).to eq [plane1, plane2]
  end

  it 'allows planes to to take off & confirm they have left the airport' do
    #plane1, plane2, plane3 = Plane.new, Plane.new, Plane.new
    plane1 = Plane.new
    plane2 = Plane.new
    plane3 = Plane.new
    subject.land_plane(plane1)
    subject.land_plane(plane2)
    subject.land_plane(plane3)
    expect(subject.take_off(plane1)).to eq "#{plane1} has left the #{subject}"
    expect(subject.take_off(plane3)).to eq "#{plane3} has left the #{subject}"
    expect(subject.terminal).to eq [plane2]
  end

  it 'should only allow planes at the airport to take off' do
    plane1, plane2, plane3 = Plane.new, Plane.new, Plane.new
    subject.land_plane(plane1)
    subject.land_plane(plane2)
    subject.take_off(plane2)
    expect { subject.take_off(plane2) }.to raise_error("#{plane2} is not at this airport")
    expect {subject.take_off(plane3) }.to raise_error("#{plane3} is not at this airport")
  end

  it 'should not allow planes at the airport to land again' do
    plane1, plane2, plane3 = Plane.new, Plane.new, Plane.new
    subject.land_plane(plane1)
    subject.land_plane(plane2)
    expect { subject.land_plane(plane2) }.to raise_error("#{plane2} is already at the airport")
  end

  it 'should not allow planes that have landed at another airport to land again' do
    plane1 = Plane.new
    airport = Airport.new
    another_airport = Airport.new
    another_airport.land_plane(plane1)
    expect { airport.land_plane(plane1) }. to raise_error("#{plane1} is not flying.")
  end

  it 'refuses further landings when airport is at capcity' do
    plane1 = Plane.new
    10.times { subject.land_plane(Plane.new) }
    expect { subject.land_plane(plane1) }. to raise_error("#{plane1} cannot land. #{subject} is at capacity.")
  end

end
