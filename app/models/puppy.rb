class Puppy < ActiveRecord::Base

before_create :default_values

def default_values
  self.rating = 0
  photo = get_photo()
  self.path = "http://farm#{photo.farm}.staticflickr.com/#{photo.server}/#{photo.id}_#{photo.secret}.jpg"
end

def get_photo
    flickr = Flickr.new('flickr.yml')
    photos = flickr.photos.search(:tags => 'puppy', :per_page => 500)
    return photos.sample
end

end
