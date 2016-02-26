class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t| #モデル名は先頭大文字単数形のUserなのでテーブル名は小文字複数形のusers
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps null: false
      
      t.index :email, unique: true #追加した行
    end
  end
end
