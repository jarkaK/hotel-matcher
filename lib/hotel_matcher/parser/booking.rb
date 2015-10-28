module HotelMatcher
  module Parser
    # This is the class that matches hotel with booking.com website
    class Booking < Base
      def initialize
        @request_url = 'http://www.booking.com/searchresults.en-gb.html?si=ai,co,ci&ss=#HOTEL_NAME#'
      end

      def parse(result)
        href_element = Nokogiri::HTML(result).css('#hotelWrapper a')

        return nil if href_element.size == 0

        href_base = 'https://www.booking.com' + href_element.first['href']
        href = href_base.split('?')

        # two possible format of urls can be found
        # TODO: try to find search url where it is always the same / use official booking.com API if they provide it
        if href.size > 1
          href.first
        else
          href_base.split(';').first.sub('en-gb.html', 'html')
        end
      end
    end
  end
end
