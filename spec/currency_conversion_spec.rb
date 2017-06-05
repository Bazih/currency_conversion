require 'spec_helper'

describe CurrencyConversion do

  describe 'Cbr' do
    let(:obj) {CurrencyConversion::Cbr.new}

    it 'should returns Cbr.data a hash data' do
      expect(obj.data).to include(:JPY)
    end
  end

  describe 'Calculations' do
    let(:calculation) { CurrencyConversion::Calculations.new }

    before do
      obj = instance_double(CurrencyConversion::Cbr, data: { :KZT=>["100", "18.1047"], :CNY=>["10", "83.0747"] })
      allow(CurrencyConversion::Calculations).to receive(:cbr) { obj.data }
    end

    it '#upcase_params' do
      expect(calculation.send(:upcase_params, 'zaR', ['cHf', 'jpy'])).to eq(['ZAR', ['CHF', 'JPY']])
    end

    it '#from_rub' do
      expect(calculation.send(:from_rub, 'KZT', 5)).to eq(27.61713809121388)
    end

    it '#to_rub' do
      expect(calculation.send(:to_rub, 'KZT', 50)).to eq(9.05235)
    end

    it '#to_currency' do
      expect(calculation.send(:to_currency, 'CNY', 'KZT', 50)).to eq(2294.285461786166)
    end

    it 'should conversion from one currency to another to preset accuracy' do
      expect(calculation.calc('RUB', 1, ['KZT', 'CNY'], 6)).to eq({:KZT=>5.523428, :CNY=>0.120374})
    end
  end
end
