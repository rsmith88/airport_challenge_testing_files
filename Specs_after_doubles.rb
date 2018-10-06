require 'airport'
require 'plane'

describe Airport do
  let(:plane1) { double :plane1 }
  let(:plane2) { double :plane2 }
  let(:plane3) { double :plane3 }

  it 'allows a plane to land' do
    allow(plane1).to receive(:flying).and_return(true)
    allow(plane1).to receive(:grounded).and_return(true)
    subject.land_plane(plane1)
    expect(subject.terminal).to eq [plane1]
  end

  it 'allows multiple planes to land' do
    allow(plane1).to receive(:flying).and_return(true)
    allow(plane1).to receive(:grounded).and_return(true)
    subject.land_plane(plane1)
    allow(plane2).to receive(:flying).and_return(true)
    allow(plane2).to receive(:grounded).and_return(true)
    subject.land_plane(plane2)
    expect(subject.terminal).to eq [plane1, plane2]
  end

  it 'allows planes to to take off & confirm they have left the airport' do
    allow(plane1).to receive(:flying).and_return(true)
    allow(plane1).to receive(:grounded).and_return(true)
    subject.land_plane(plane1)
    allow(plane2).to receive(:flying).and_return(true)
    allow(plane2).to receive(:grounded).and_return(true)
    subject.land_plane(plane2)
    allow(plane1).to receive(:in_flight).and_return(true)
    expect(subject.take_off(plane1)).to eq "#{plane1} has left the #{subject}"
    expect(subject.terminal).to eq [plane2]
  end

  it 'should only allow planes at the airport to take off' do
    allow(plane1).to receive(:flying).and_return(true)
    allow(plane1).to receive(:grounded).and_return(true)
    subject.land_plane(plane1)
    allow(plane2).to receive(:flying).and_return(true)
    allow(plane2).to receive(:grounded).and_return(true)
    subject.land_plane(plane2)
    allow(plane2).to receive(:in_flight).and_return(true)
    subject.take_off(plane2)
    expect { subject.take_off(plane2) }.to raise_error("#{plane2} is not at this airport")
    expect {subject.take_off(plane3) }.to raise_error("#{plane3} is not at this airport")
  end

  it 'should not allow planes at the airport to land again' do
    allow(plane1).to receive(:flying).and_return(true)
    allow(plane1).to receive(:grounded).and_return(true)
    subject.land_plane(plane1)
    allow(plane2).to receive(:flying).and_return(true)
    allow(plane2).to receive(:grounded).and_return(true)
    subject.land_plane(plane2)
    expect { subject.land_plane(plane2) }.to raise_error("#{plane2} is already at the airport")
  end

  it 'should not allow planes that have landed at another airport to land again' do
    another_airport = Airport.new
    allow(plane1).to receive(:flying).and_return(true)
    allow(plane1).to receive(:grounded).and_return(true)
    another_airport.land_plane(plane1)
    allow(plane1).to receive(:flying).and_return(false)
    expect { subject.land_plane(plane1) }. to raise_error("#{plane1} is not flying.")
  end

  it 'refuses further landings when airport is at capcity' do
    allow(plane1).to receive(:flying).and_return(true)
    allow(plane1).to receive(:grounded).and_return(true)
    10.times { subject.land_plane(Plane.new) }
    expect { subject.land_plane(plane1) }. to raise_error("#{plane1} cannot land. #{subject} is at capacity.")
  end

end
