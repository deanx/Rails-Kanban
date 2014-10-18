json.array!(@states) do |state|
  json.extract! state, :id, :title, :order
  json.url state_url(state, format: :json)
end
