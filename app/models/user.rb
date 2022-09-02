class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :profile_image


  #以下カリキュラムのヒントをもとに作成
  # foreign_key（FK）には、@user.xxxとした際に「@user.idがfollower_idなのかfollowed_idなのか」を指定します。
  #has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # @user.booksのように、@user.yyyで、
  # そのユーザがフォローしている人orフォローされている人の一覧を出したい
  #has_many :followers, through: :@user.relationships, source: :followed


  #以下ネットより参照
  #userﾃｰﾌﾞﾙ→relationﾃｰﾌﾞﾙ
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  #relationﾃｰﾌﾞﾙ→followedﾃｰﾌﾞﾙ、followed_idを持って来る
  has_many :followings, through: :relationships, source: :followed
  #followerﾃｰﾌﾞﾙ(本当はuser)→re_relationﾃｰﾌﾞﾙ(本当relation)へfollowed_idを送る(参照）
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id",  dependent: :destroy
  #re_relationﾃｰﾌﾞﾙ→userﾃｰﾌﾞﾙへfollower_idを持って来る
  has_many :followers, through: :reverse_of_relationships, source: :follower

  #バリデーションの設定
  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }

 # ユーザーをフォローする
 def follow(user_id)
    relationships.create(followed_id: user_id)
 end
 # ユーザーのフォローを外す
 def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
 end
 # フォローしていればtrueを返す
 def following?(user)
    followings.include?(user)
 end


 def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    elsif method == 'forward'
      User.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      User.where('name LIKE ?', '%' + content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
 end

 # 検索方法分岐
  #def self.looks(search, word)
    #送られてきたsearchによって条件分岐させましょう。
    #if search == "perfect_match"#完全一致
     # @user = User.where("name LIKE?", "#{word}")#whereメソッドを使いデータベースから該当データを取得し、変数に代入します。
    #elsif search == "forward_match"#前方一致
     # @user = User.where("name LIKE?","#{word}%")
   # elsif search == "backward_match"#後方一致
      #@user = User.where("name LIKE?","%#{word}")
    #elsif search == "partial_match"#部分一致
     # @user = User.where("name LIKE?","%#{word}%")
      #完全一致以外の検索方法は、#{word}の前後(もしくは両方に)、__%__を追記することで定義することができます。
   #else
     # @user = User.all
    #end
    #nameは検索対象であるusersテーブル内のカラム名です→適宜、適したカラム名を指定しましょう。
  #end

def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
end

end
