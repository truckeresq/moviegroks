json.array!(@themes) do |theme|
  json.extract! theme, :id, :keyword
  json.url theme_url(theme, format: :json)
end
