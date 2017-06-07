require 'pstore'

module CurrencyConversion
  class StorageCache
    def get(date, data)
      if actual?(date)
        load
      else
        update(date, data)
      end
    end

    def update(date, data)
      save(date, data)
      data
    end

    private

    def load
      storage.transaction do
        storage[:data]
      end
    end

    def save(date, data)
      storage.transaction do
        storage[:date] = date
        storage[:data] = data
      end
    end

    def actual?(date)
      storage_date = storage.transaction { storage[:date] }
      date == storage_date 
    end

    def storage
      @storage ||= PStore.new('data_currencies.store')
    end
  end
end
