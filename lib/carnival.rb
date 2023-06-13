require './visitor'

require './ride'


class Carnival
    attr_reader :duration, :rides

    def initialize(duration)
      @duration = duration
      @rides = []
    end

    def add_ride(ride)
      @rides << ride
    end

    def most_popular_ride
      rides.max_by { |ride| ride.rider_log.values.sum }
    end

    def most_profitable_ride
      rides.max_by { |ride| ride.total_revenue }
    end

    def total_revenue
      rides.sum { |ride| ride.total_revenue }
    end

    def summary
      {
        visitor_count: count_visitors,
        revenue_earned: total_revenue,
        visitors: visitor_summary,
        rides: ride_summary
      }
    end
  
    