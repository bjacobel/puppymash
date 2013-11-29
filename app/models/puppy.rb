class Puppy < ActiveRecord::Base

  before_create :default_values

  def default_values
    self.rating = 0

    # keep getting new photos if this one already exists
    $photo_used = false
    begin
      photo = get_photo()
      self.path = "http://farm#{photo.farm}.staticflickr.com/#{photo.server}/#{photo.id}_#{photo.secret}.jpg"
      Puppy.all.each() do |p| 
        if p.path == self.path 
          $photo_used = true
          break 
        end 
      end
    end while $photo_used
  end

  def get_photo
    flickr = Flickr.new('flickr.yml')
    photos = flickr.photos.search(:tags => 'puppy', :per_page => 10, :sort => 'interestingness_desc', :page => (rand(9)+1))
    return photos.sample
  end

end
