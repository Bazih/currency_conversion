require 'nokogiri'
require 'open-uri'

module CurrencyConversion
  class Cbr
    def data(date)
      data_load(date)
    end

    private

    def data_load(date)
      doc = Nokogiri::HTML(open("http://www.cbr.ru/scripts/xml_daily.asp?date_req=#{date}"))
      data = {}

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