require 'spec_helper'

describe CurrencyConversion do

  let(:obj) {CurrencyConversion::Cbr.new}

  describe 'query of data' do

    it 'should returns Cbr.data a hash data' do
      expect(obj.data).to include(:JPY)
    end
  end

  describe 'calculations' do
    it 'should conversion from one currency to another to preset accuracy' do
      obj = instance_double(CurrencyConversion::Cbr, data: { :KZT=>["100", "18.1047"], :CNY=>["10", "83.0747"] })
      allow(CurrencyConversion::Calculations).to receive(:cbr) { obj.data }
      expect(CurrencyConversion::Calculations.new('RUB', 1, ['KZT', 'CNY'], 6).calc).to eq({:KZT=>5.523428, :CNY=>0.120374})
    end

    it 'should upcase for params from and to' do
      obj = instance_double(CurrencyConversion::Cbr, data: { :CHF=>["1", "58.2799"], :ZAR=>["10", "43.3103"] , :JPY=>["100", "50.8749"] })
      allow(CurrencyConversion::Calculations).to receive(:cbr) { obj.data }
      expect(CurrencyConversion::Calculations.new('jpY', 1, ['chf', 'ZaR'], 6).calc).to eq({:CHF=>0.008729, :ZAR=>0.117466})
    end
  end
end
