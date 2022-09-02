class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)#このメソッドで、引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べます。
    favorites.exists?(user_id: user.id)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%'+content)
    else
      Book.where('title LIKE ?', '%'+content+'%')
    end
  end

  # 検索方法分岐
  #def self.looks(search, word)
    #if search == "perfect_match"
      #@book = Book.where("title LIKE?","#{word}")
    #elsif search == "forward_match"
      #@book = Book.where("title LIKE?","#{word}%")
    #elsif search == "backward_match"
     # @book = Book.where("title LIKE?","%#{word}")
    #elsif search == "partial_match"
     # @book = Book.where("title LIKE?","%#{word}%")
    #else
     # @book = Book.all
    #end
  #end


end
