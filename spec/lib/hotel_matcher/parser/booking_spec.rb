require 'spec_helper'

describe HotelMatcher::Parser::Booking do
  describe '#get_hotel_url' do
    before do
      expect(HTTParty).to receive(:get).with(request_url).and_return(response)
    end

    let(:hotel_name) { 'DoubleTree Hilton Amsterdam' }
    let(:request_url) do
      "http://www.booking.com/searchresults.en-gb.html?si=ai,co,ci&ss=#{hotel_name}"
    end

    subject { HotelMatcher::Parser::Booking.new.get_hotel_url(hotel_name) }

    context 'hotel is found' do
      let(:result) { 'https://www.booking.com/hotel/nl/double-tree-by-hilton-amsterdam-centraal-station.en-gb.html' }
      let(:response) do
        file = File.open('./spec/responses/booking_hotels_found.html', 'rb')
        double(body: file.read, code: 200)
      end

      it 'when a hotels are found' do
        expect(subject).to eq(result)
      end
    end

    context 'hotel is not found' do
      let(:response) do
        file = File.open('./spec/responses/booking_no_hotels.html', 'rb')
        double(body: file.read, code: 200)
      end

      it 'when result array is empty' do
        expect(subject).to be_nil
      end
    end

    context 'an error in response' do
      before do
        expect(LOGGER).to receive(:warn)
      end

      let(:response) { double(body: 'some error', code: 400) }

      it 'when result array is empty' do
        expect(subject).to be_nil
      end
    end
  end
end
