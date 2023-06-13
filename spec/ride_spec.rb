require 'rspec'
require './lib/visitor.rb'
require './lib/ride.rb'


describe Ride do
  let(:ride1) { Ride.new({ name: 'Carousel', min_height: 54, admission_fee: 1, excitement: :gentle }) }
  let(:ride2) { Ride.new({ name: 'rollercoster', min_height: 24, admission_fee: 1, excitement: :thrilling }) }
  let(:visitor1) { Visitor.new('Bruce', 54, '$10') }
  let(:visitor2) { Visitor.new('Tucker', 36, '$5') }
  let(:visitor3) { Visitor.new('Penny', 64, '$15') }

  before do
    visitor1.add_preference(:gentle)
    visitor2.add_preference(:gentle)
  end

  describe '#initialize' do
    it 'creates a new Ride instance with the given attributes' do
      expect(ride1.name).to eq('Carousel')
      expect(ride1.min_height).to eq(54)
      expect(ride1.admission_fee).to eq(1)
      expect(ride1.excitement).to eq(:gentle)
      expect(ride1.rider_log).to eq({})
    end
  end

  describe '#total_revenue' do
    it 'calculates the total revenue earned by the ride' do
      ride1.board_rider(visitor1)
      ride1.board_rider(visitor2)
      ride1.board_rider(visitor1)

      expect(ride1.total_revenue).to eq(2)
    end
  end

  describe '#board_rider' do
    it 'boards a rider and updates the rider log if they meet the requirements' do
      ride1.board_rider(visitor1)

      expect(ride1.rider_log).to eq({ visitor1 => 1 })
    end

    it 'reduces the rider\'s spending money by the admission fee when boarding a ride' do
      ride1.board_rider(visitor1)

      expect(visitor1.spending_money).to eq(9)
    end

    it 'does not board a rider who is not tall enough' do
      ride1.board_rider(visitor2)

      expect(ride1.rider_log).to eq({})
    end

    it 'does not board a rider who does not have a matching preference for the ride\'s excitement level' do
      ride1.board_rider(visitor2)

      expect(ride1.rider_log).to eq({})
    end


  end
end
