require './visitor'

class Ride
    attr_reader :name, :min_height, :admission_fee, :excitement, :rider_log

    def initialize(options)
      @name = options[:name]
      @min_height = options[:min_height]
      @admission_fee = options[:admission_fee]
      @excitement = options[:excitement]
      @rider_log = {}
    end

    def total_revenue
      rider_log.values.sum * admission_fee
    end
    
    def board_rider(visitor)
        if visitor.height >= min_height && visitor.preferences.include?(excitement)
            visitor.reduce_spending_money(admission_fee)
            rider_log[visitor] ||= 0
            rider_log[visitor] += 1
            
        else
            nil
        end
    end
end
