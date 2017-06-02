require "currency_conversion/version"
require "currency_conversion/cbr"

module CurrencyConversion
	class Calculations
		def calc(from, amount, to, precision)

			upcase_from = from.upcase
			@obj = CurrencyConversion::Cbr.new
			
			out = {}
			if upcase_from == 'RUB'
				to.each do |cur|
					cur_up = cur.upcase
					rez = amount.to_f / @obj.data[:"#{cur_up}"][1].to_f * @obj.data[:"#{cur_up}"][0].to_f
					out.merge!("#{cur_up}": rez.round(precision))
				end
			else
				to.each do |cur|
					cur_up = cur.upcase
					if cur_up == 'RUB'
						rez = @obj.data[:"#{upcase_from}"][1].to_f * amount.to_f / @obj.data[:"#{upcase_from}"][0].to_f
						out.merge!("#{cur_up}": rez.round(precision))
					else
						from_rub = @obj.data[:"#{upcase_from}"][1].to_f * amount.to_f / @obj.data[:"#{upcase_from}"][0].to_f
						rez = from_rub / @obj.data[:"#{cur_up}"][1].to_f * @obj.data[:"#{cur_up}"][0].to_f
						out.merge!("#{cur_up}": rez.round(precision))
					end
				end
			end
			out
		end
	end
end
