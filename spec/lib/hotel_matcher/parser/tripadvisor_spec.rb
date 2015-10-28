require 'spec_helper'

describe HotelMatcher::Parser::Tripadvisor do
  describe '#find_url' do
    let(:hotel_name) { 'Some hotel' }
    let(:request_url) do
      'http://www.tripadvisor.com/TypeAheadJson?types=hotel&defaultListInsertionType=hotel&query=Some hotel&action=API'
    end

    subject { HotelMatcher::Parser::Tripadvisor.new.get_hotel_url(hotel_name) }

    before do
      expect(HTTParty).to receive(:get).with(request_url).and_return(response)
    end

    context 'hotel is found' do
      let(:response)  do
        file = File.open('./spec/responses/tripadvisor_hotels_found.json', 'rb')
        double(body: file.read, code: 200)
      end

      it { expect(subject).to eq('http://www.tripadvisor.com/Hotel_Result_url.html') }
    end

    context 'hotel is not found' do
      let(:response)  do
        file = File.open('./spec/responses/tripadvisor_no_hotels.json', 'rb')
        double(body: file.read, code: 200)
      end

      it { expect(subject).to be_nil }
    end

    context 'json is not valid' do
      let(:response) { double(body: '{[ something], { }', code: 200) }

      before do
        expect(LOGGER).to receive(:error)
      end

      it { expect(subject).to be_nil }
    end

    context 'an error in response' do
      before do
        expect(LOGGER).to receive(:warn)
      end

      let(:response) { double(body: 'some error', code: 400) }

      it { expect(subject).to be_nil }
    end
  end
end
