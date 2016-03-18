class Article < ActiveRecord::Base

	has_many :comments, :dependent => :destroy
	has_many :taggings, :dependent => :destroy
	belongs_to :user
    has_many :tags, :through => :taggings, :dependent => :destroy
   
      has_attached_file :image, styles: { medium: "600*450>" ,thumbs: "200*180>"}
       crop_attached_file :image, :aspect => "19:8"
      validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']

def self.search(search)
  where("title LIKE ?", "%#{search}%") 
  
end

end
