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
    def self.total_revenues(carnivals)
        carnivals.sum { |carnival| carnival.total_revenue }
      end
  
      def count_visitors
          rides.flat_map { |ride| ride.rider_log }.map { |rider_log| rider_log.first }.uniq.size
  
      end
  
      def visitor_summary
          rides.flat_map do |ride|
            ride.rider_log.map do |visitor, ride_count|
              {
                visitor: visitor,
                favorite_ride: visitor_favorite_ride(visitor),
                total_money_spent: total_money_spent(visitor)
              }
            end
          end
        end
      
        def visitor_favorite_ride(visitor)
          rides.max_by { |ride| ride.rider_log[visitor].to_i }
        end
      
        def total_money_spent(visitor)
          rides.sum { |ride| ride.rider_log[visitor].to_i * ride.admission_fee }
        end
      
        def ride_summary
          rides.map do |ride|
            {
              ride: ride,
              riders: ride.rider_log.keys,
              total_revenue: ride.total_revenue
            }
          end
        end
      end  
  
    