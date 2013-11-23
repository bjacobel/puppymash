json.array!(@puppies) do |puppy|
  json.extract! puppy, :path, :rating
  json.url puppy_url(puppy, format: :json)
end
