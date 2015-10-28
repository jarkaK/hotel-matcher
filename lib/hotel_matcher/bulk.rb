module HotelMatcher
  # This is the class that matches a hotel with all supported websites
  class Bulk
    MATCHERS = %w(tripadvisor booking holidaycheck)

    def self.get_hotel_urls(hotel_name)
      result = {}

      MATCHERS.each do |matcher|
        site_result = Object.const_get("HotelMatcher::Parser::#{matcher.capitalize}").new.get_hotel_url(hotel_name)
        result[matcher] = site_result

        unless site_result
          LOGGER.info("no hotel found: hotel_name='#{hotel_name}' matcher='#{matcher}'")
        end
      end

      enqueue(result)

      result
    end

    def self.enqueue(result)
      puts "Results #{result} enqueued"
    end
  end
end
