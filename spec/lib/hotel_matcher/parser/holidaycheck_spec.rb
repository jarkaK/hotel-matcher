require 'spec_helper'

describe HotelMatcher::Parser::Holidaycheck do
  describe '#get_hotel_url' do
    before do
      expect(HTTParty).to receive(:get).with(request_url).and_return(response)
    end

    let(:hotel_name) { 'DoubleTree Hilton Amsterdam' }
    let(:request_url) do
      "https://www.holidaycheck.de/service/search/v1/hcde.suggestSearch?typ=hid&view=json&anfrage=#{hotel_name}"
    end
    let(:response) do
      file = File.open('./spec/responses/holidaycheck_hotels_found.json', 'rb')
      double(body: file.read, code: 200)
    end
    let(:url_with_id) { 'https://www.holidaycheck.de/suggestsearch.html?itemId=313225&itemType=hid' }
    let(:expected_url) { 'http://final_url' }

    subject { HotelMatcher::Parser::Holidaycheck.new.get_hotel_url(hotel_name) }

    context 'hotel is found' do
      before do
        expect(HTTParty).to receive(:get).with(url_with_id).and_return(result)
      end

      let(:result) { double(request: double(last_uri: expected_url), code: 200) }

      it { expect(subject).to eq(expected_url) }
    end

    context 'error during second call' do
      before do
        expect(HTTParty).to receive(:get).with(url_with_id).and_return(result)
      end

      let(:result) { double(request: double(last_uri: expected_url), code: 400) }

      it { expect(subject).to eq(url_with_id) }
    end

    context 'hotel is not found' do
      let(:response) do
        file = File.open('./spec/responses/holidaycheck_no_hotels.json', 'rb')
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
