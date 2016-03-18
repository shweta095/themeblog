class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_attached_file :image, :styles => { :small => "150x150>" }
  
validates_attachment_size :image, :less_than => 5.megabytes
validates_attachment_content_type :image, :content_type => ['image/jpeg', 'image/png']

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
          has_many :articles, :dependent => :destroy
         has_many :comments, :dependent => :destroy
end
