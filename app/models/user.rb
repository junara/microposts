class User < ActiveRecord::Base
    before_save { self.email = email.downcase } #小文字に変換
    validates :name , presence: true , length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email , presence: true , length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
    validates :profile , presence: false , length: { maximum: 100 }
    validates :location , presence: false , length: { maximum: 50 }
    
    has_secure_password
    
    has_many :microposts

    # フォロー　用の　リレーション
    has_many :following_relationships, class_name:  "Relationship",
                                     foreign_key: "follower_id",
                                     dependent:   :destroy
    has_many :following_users, through: :following_relationships, source: :followed
    has_many :follower_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
    has_many :follower_users, through: :follower_relationships, source: :follower  
    
    # お気に入り　用の　リレーション
    has_many :likes, dependent: :destroy ,foreign_key: "liker_id"
    has_many :like_microposts , through: :likes , source: :micropost_ref
    
    # 他のユーザーをフォローする
    def follow(other_user)
        following_relationships.find_or_create_by(followed_id: other_user.id)
    end
    
    # フォローしているユーザーをアンフォローする
    def unfollow(other_user)
        following_relationship = following_relationships.find_by(followed_id: other_user.id)
        following_relationship.destroy if following_relationship
    end
    
    # あるユーザーをフォローしているかどうか？
    def following?(other_user)
        following_users.include?(other_user)
    end

    def feed_items
        Micropost.where(user_id: following_user_ids + [self.id])
    end
    
    #お気に入りの投稿を追加
    def like_add(other_micropost)
        likes.find_or_create_by(likedmicropost_id: other_micropost.id)
    end
    
    # お気に入りをキャンセルする
    def like_del(other_micropost)
        like = likes.find_by(likedmicropost_id: other_micropost.id)
        like.destroy if like
    end
    
end
