require 'currency_conversion/version'
require 'currency_conversion/cbr'

module CurrencyConversion
  class Calculations
    def initialize
      @@obj = Calculations.cbr
    end

    def calc(from, amount, to, precision)
      @from, @to = upcase_params(from, to)[0], upcase_params(from, to)[1]
      out = {}

      @to.each do |cur|
        if @from == 'RUB'
          out.merge!("#{cur}": from_rub(cur, amount).round(precision))
        elsif cur == 'RUB'
          out.merge!("#{cur}": to_rub(@from, amount).round(precision))
        else
          out.merge!("#{cur}": to_currency(@from, cur, amount).round(precision))
        end
      end
      out
    end

    private

    def self.cbr
      CurrencyConversion::Cbr.new.data
    end

    def upcase_params(from, to)
      to.map! {|x| x.upcase }
      return from.upcase, to
    end

    def from_rub(to, amount)
      amount.to_f / @@obj[:"#{to}"][1].to_f * @@obj[:"#{to}"][0].to_f
    end

    def to_rub(from, amount)
      @@obj[:"#{from}"][1].to_f * amount.to_f / @@obj[:"#{from}"][0].to_f
    end

    def to_currency(from, to, amount)
      to_rub(from, amount) / @@obj[:"#{to}"][1].to_f * @@obj[:"#{to}"][0].to_f
    end
  end
end
