class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User" #Userモデルを参照してフォローしたユーザーを指定する
  belongs_to :followed, class_name: "User" #Userモデルを参照してフォロされたユーザーを指定する
end
