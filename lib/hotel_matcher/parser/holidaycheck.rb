module HotelMatcher
  module Parser
    # This is the class that matches hotel with holidaycheck.de website
    class Holidaycheck < Base
      def initialize
        @request_url =
          'https://www.holidaycheck.de/service/search/v1/hcde.suggestSearch?typ=hid&view=json&anfrage=#HOTEL_NAME#'
      end

      private

      def parse(result)
        result = JSON.parse(result)

        return if result['items'].size == 0

        hotel_id = result['items'].first['id']

        # this is not necessary and it is here in order to ffulfil the requirements
        hotel_url = "https://www.holidaycheck.de/suggestsearch.html?itemId=#{hotel_id}&itemType=hid"
        response = get_response(hotel_url)

        # this would be enough to return, it will be redirected
        return hotel_url unless response

        response.request.last_uri.to_s.split('?').first
      rescue JSON::ParserError => e
        LOGGER.error "JSON::ParseError #{e.message}"
      end
    end
  end
end
