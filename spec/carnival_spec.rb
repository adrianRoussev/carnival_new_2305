
require 'rspec'
require './lib/visitor.rb'
require './lib/ride.rb'
require './lib/carnival.rb'

RSpec.describe 'Carnival' do
      let(:carnival) { Carnival.new(14) }
      let(:ride1) { Ride.new({ name: 'Carousel', min_height: 24, admission_fee: 1, excitement: :gentle }) }
      let(:ride2) { Ride.new({ name: 'Ferris Wheel', min_height: 36, admission_fee: 5, excitement: :gentle }) }
      let(:ride3) { Ride.new({ name: 'Roller Coaster', min_height: 54, admission_fee: 2, excitement: :thrilling }) }

      it 'creates a carnival with the provided duration' do
        expect(carnival.duration).to eq(14)
      end

      it 'adds a ride to the carnival' do
        carnival.add_ride(ride1)
        carnival.add_ride(ride2)
        expect(carnival.rides).to eq([ride1, ride2])
      end

      it 'returns the most popular ride of the carnival' do
        visitor1 = Visitor.new('Bruce', 54, '$10')
        visitor2 = Visitor.new('Tucker', 36, '$5')
        visitor1.add_preference(:gentle)
        visitor2.add_preference(:gentle)

        ride1.board_rider(visitor1)
        ride1.board_rider(visitor2)
        ride2.board_rider(visitor1)

        carnival.add_ride(ride1)
        carnival.add_ride(ride2)

        expect(carnival.most_popular_ride).to eq(ride1)
      end

      it 'returns the most profitable ride of the carnival' do
        visitor1 = Visitor.new('Bruce', 54, '$10')
        visitor2 = Visitor.new('Tucker', 36, '$5')
        visitor3 = Visitor.new('Penny', 64, '$15')
        
        visitor2.add_preference(:thrilling)
        visitor3.add_preference(:thrilling)

        ride1.board_rider(visitor1)
        ride1.board_rider(visitor2)
        ride1.board_rider(visitor3)
        ride2.board_rider(visitor1)
        ride3.board_rider(visitor2)
        ride3.board_rider(visitor3)

        carnival.add_ride(ride1)
        carnival.add_ride(ride2)
        carnival.add_ride(ride3)

        expect(carnival.most_profitable_ride).to eq(ride3)
      end

      it 'calculates the total revenue earned from all rides of the carnival' do
        visitor1 = Visitor.new('Bruce', 54, '$10')
        visitor2 = Visitor.new('Tucker', 36, '$5')
        visitor3 = Visitor.new('Penny', 64, '$15')
        visitor2.add_preference(:thrilling)
        visitor3.add_preference(:thrilling)
      

        ride1.board_rider(visitor1)
        ride1.board_rider(visitor2)
        ride1.board_rider(visitor3)
        ride2.board_rider(visitor1)
        ride3.board_rider(visitor2)
        ride3.board_rider(visitor3)

        carnival.add_ride(ride1)
        carnival.add_ride(ride2)
        carnival.add_ride(ride3)

        expect(carnival.total_revenue).to eq(2)
      end


      it 'returns a summary hash with visitor count, revenue earned, visitor details, and ride details' do
        visitor1 = Visitor.new('Bruce', 54, '$10')
        visitor2 = Visitor.new('Tucker', 36, '$5')
        visitor3 = Visitor.new('Penny', 64, '$15')
        visitor2.add_preference(:thrilling)
        visitor3.add_preference(:thrilling)

        ride1.board_rider(visitor1)
        ride1.board_rider(visitor2)
        ride1.board_rider(visitor3)
        ride2.board_rider(visitor1)
        ride3.board_rider(visitor2)
        ride3.board_rider(visitor3)

        carnival.add_ride(ride1)
        carnival.add_ride(ride2)
        carnival.add_ride(ride3)

        expected_summary = {
          visitor_count: 2,
          revenue_earned: 2,
          visitors: [
            {
              visitor: visitor3,
              favorite_ride: ride3,
              total_money_spent: 2
            }
           
          ],
          rides: [
            {
              ride: ride1,
              riders: [],
              total_revenue: 0
            },
            {
              ride: ride2,
              riders: [],
              total_revenue: 0
            },
            {
              ride: ride3,
              riders: [ visitor3],
              total_revenue: 2
            }
          ]
        }

        expect(carnival.summary).to eq(expected_summary)
      end

      it 'calculates the total revenue of all carnivals' do
        visitor1 = Visitor.new('Bruce', 54, '$10')
        visitor2 = Visitor.new('Tucker', 36, '$5')
        visitor3 = Visitor.new('Penny', 64, '$15')
        
        visitor2.add_preference(:thrilling)
        visitor3.add_preference(:thrilling)
        carnival1 = Carnival.new(7)
        carnival2 = Carnival.new(14)

        ride1.board_rider(visitor1)
        ride2.board_rider(visitor1)
        ride3.board_rider(visitor3)

        carnival1.add_ride(ride1)
        carnival1.add_ride(ride3)
        carnival2.add_ride(ride3)

        total_revenues = Carnival.total_revenues([carnival1, carnival2])

        expect(total_revenues).to eq(4)
      end
    end
  

    






