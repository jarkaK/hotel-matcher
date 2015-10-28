require 'spec_helper'

describe HotelMatcher::Bulk do
  describe '.get_hotel_ursl' do
    before do
      expect(HotelMatcher::Parser::Tripadvisor).to receive(:new).and_return(tripadvisor_matcher)
      expect(tripadvisor_matcher).to receive(:get_hotel_url).and_return(results['tripadvisor'])

      expect(HotelMatcher::Parser::Booking).to receive(:new).and_return(booking_matcher)
      expect(booking_matcher).to receive(:get_hotel_url).and_return(results['booking'])

      expect(HotelMatcher::Parser::Holidaycheck).to receive(:new).and_return(holidaycheck_matcher)
      expect(holidaycheck_matcher).to receive(:get_hotel_url).and_return(results['holidaycheck'])

      expect(LOGGER).to receive(:info).with("no hotel found: hotel_name='#{hotel_name}' matcher='holidaycheck'")
    end

    let(:hotel_name) { 'Some hotel Amsterdam' }
    let(:tripadvisor_matcher)  { double }
    let(:booking_matcher)      { double }
    let(:holidaycheck_matcher) { double }

    let(:results) do
      {
        'tripadvisor' => 'tripadvisore result',
        'booking' => 'booking result',
        'holidaycheck' => nil
      }
    end

    subject { HotelMatcher::Bulk.get_hotel_urls(hotel_name) }

    it 'when everything is ok' do
      expect(subject).to eq(results)
    end
  end
end
