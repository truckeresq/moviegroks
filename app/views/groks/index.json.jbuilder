json.array!(@groks) do |grok|
  json.extract! grok, :id, :user_id, :title, :book_id, :theme_id
  json.url grok_url(grok, format: :json)
end
