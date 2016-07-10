json.array!(@records) do |record|
  json.extract! record, :id, :item, :description, :price, :quantity, :supplier, :link, :status
  json.url record_url(record, format: :json)
end
