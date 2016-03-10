class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id , presence: true
  validates :content , presence: true , length: { maximum: 140 }
  
  has_many :likes, dependent: :destroy , foreign_key: "likedmicropost_id", class_name:  "Like"
end
