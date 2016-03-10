class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :liker, index: true
      t.references :likedmicropost, index: true

      t.timestamps null: false
      
      t.index [:liker_id , :likedmicropost_id] , unique: true
    end
  end
end
