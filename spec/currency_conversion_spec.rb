require 'spec_helper'

describe CurrencyConversion do

  let(:obj) {CurrencyConversion::Cbr.new}
  let(:rub) {CurrencyConversion::Calculations.new}

  describe 'query of data' do

    it 'should returns Cbr.data a hash data' do
      expect(obj.data).to have_key(:JPY)
    end
  end

  describe 'calculations' do
    it 'should conversion from one currency to another to preset accuracy' do
      allow(CurrencyConversion::Cbr).to receive(:data).and_return({
         :JPY=>["100", "50.8749"],
         :KZT=>["100", "18.1047"],
         :CAD=>["1", "41.9354"],
         :KGS=>["100", "82.9601"],
         :CNY=>["10", "83.0747"],
         :CHF=>["1", "58.2799"],
         :ZAR=>["10", "43.3103"],
         :KRW=>["1000", "50.3873"]
         })

      expect(rub.calc('RUB', 1, ['KZT', 'CNY'], 6)).to eq({:KZT=>5.523428, :CNY=>0.120374})
    end

    it 'should upcase for params from and to' do
      expect(rub.calc('ruB', 1, ['KzT', 'CnY'], 6)).to eq({:KZT=>5.523428, :CNY=>0.120374})
    end
  end
end
