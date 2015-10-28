module HotelMatcher
  module Parser
    # This is the base parent class, single matching classes are inherited
    class Base
      def get_hotel_url(hotel_name)
        @hotel_name = hotel_name
        response = get_response(url)

        return nil unless response

        parse(response.body)
      end

      private

      def parse(result)
        fail NotImplementedError
      end

      def url
        @request_url.sub('#HOTEL_NAME#', @hotel_name)
      end

      def get_response(request)
        response = HTTParty.get(request)

        if response.code >= 400
          LOGGER.warn "An error in respose. url='@request_url' code='#{response.code}'"
          return nil
        end

        response
      rescue HTTParty::Error => e
        LOGGER.error "HttParty::Error #{e.message}"
        nil
      rescue Errno::ECONNREFUSED => e
        LOGGER.error "Errno::ECONNREFUSED #{e.message}"
        nil
      end
    end
  end
end
