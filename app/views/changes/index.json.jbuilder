json.array!(@changes) do |change|
  json.extract! change, :id, :story_id, :user_id, :state_from, :state_to, :date
  json.url change_url(change, format: :json)
end
