class Article < ActiveRecord::Base

	has_many :comments, :dependent => :destroy
	has_many :taggings, :dependent => :destroy
	belongs_to :user
    has_many :tags, :through => :taggings, :dependent => :destroy
   
      has_attached_file :image, styles: { medium: "600*450>" ,thumbs: "200*180>"}
       crop_attached_file :image, :aspect => "19:8"
      validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']

def tag_list
  self.tags.collect do |tag|
    tag.name
  end.join(", ")
end
def tag_list=(tags_string)
  tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
  new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
  self.tags = new_or_found_tags
end

def self.search(search)
  where("title LIKE ?", "%#{search}%") 
  
end

end
