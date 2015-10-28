module HotelMatcher
  module Parser
    # This is the class that matches hotel with tripadvisor.com website
    class Tripadvisor < Base
      def initialize
        @request_url = 'http://www.tripadvisor.com/' \
        'TypeAheadJson?types=hotel&defaultListInsertionType=hotel&query=#HOTEL_NAME#&action=API'
      end

      def parse(result)
        result = JSON.parse(result)
        return nil if result['results'].size == 0

        'http://www.tripadvisor.com' + result['results'].first['urls'].first['url']
      rescue JSON::ParserError => e
        LOGGER.error "JSON::ParseError #{e.message}"
      end
    end
  end
end
