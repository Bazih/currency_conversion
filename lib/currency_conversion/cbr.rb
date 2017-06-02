#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'

module CurrencyConversion
	class Cbr
		def data
			data_load
		end

		private

		def data_load
			data = {}
			today = Date.today.strftime('%d.%m.%Y')
			doc = Nokogiri::HTML(open("http://www.cbr.ru/scripts/xml_daily.asp?date_req=#{today}"))

			doc.xpath('/html/body/valcurs/valute/*').each do |x|
				@kode = x.text if x.name == 'charcode'
				@nominal = x.text.gsub(/,/, '.') if x.name == 'nominal'
				@value = x.text.gsub(/,/, '.') if x.name == 'value'
				data.merge!({"#{@kode}": [@nominal, @value]})
			end
			data
		end
	end
end