require "currency_conversion/version"
require "currency_conversion/cbr"

module CurrencyConversion
	class Calculations
		def initialize(from, amount, to, precision)
			@from = from
			@amount = amount
			@to = to
			@precision = precision
		end

		def calc
			upcase_from = @from.upcase
			@obj = Calculations.cbr
			
			out = {}
			if upcase_from == 'RUB'
				@to.each do |cur|
					cur_up = cur.upcase
					rez = @amount.to_f / @obj[:"#{cur_up}"][1].to_f * @obj[:"#{cur_up}"][0].to_f
					out.merge!("#{cur_up}": rez.round(@precision))
				end
			else
				@to.each do |cur|
					cur_up = cur.upcase
					if cur_up == 'RUB'
						rez = @obj[:"#{upcase_from}"][1].to_f * @amount.to_f / @obj[:"#{upcase_from}"][0].to_f
						out.merge!("#{cur_up}": rez.round(@precision))
					else
						from_rub = @obj[:"#{upcase_from}"][1].to_f * @amount.to_f / @obj[:"#{upcase_from}"][0].to_f
						rez = from_rub / @obj[:"#{cur_up}"][1].to_f * @obj[:"#{cur_up}"][0].to_f
						out.merge!("#{cur_up}": rez.round(@precision))
					end
				end
			end
			out
		end

		def self.cbr
			CurrencyConversion::Cbr.new.data
		end
	end
end
