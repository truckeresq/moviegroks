json.array!(@favorite_quotes) do |favorite_quote|
  json.extract! favorite_quote, :id
  json.url favorite_quote_url(favorite_quote, format: :json)
end
