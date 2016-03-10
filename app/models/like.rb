class Like < ActiveRecord::Base
  belongs_to :user_ref , :class_name => 'User', :foreign_key => "liker_id"
  belongs_to :micropost_ref , :class_name => 'Micropost' , :foreign_key => "likedmicropost_id"

end
