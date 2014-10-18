json.array!(@stories) do |story|
  json.extract! story, :id, :title, :code, :points
  json.url story_url(story, format: :json)
end
