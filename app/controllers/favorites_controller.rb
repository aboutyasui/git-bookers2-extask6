class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)#book_idにbook.idを入れて、Favoriteモデルに新しいオブジェクトを作る
    favorite.save#作ったオブジェのセーブ（いいねが完了）
    redirect_to request.referer #元のviewに戻ってきます。
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    #↑ログイン中のユーザーで「book_idにbook.idを入れてあるオブジェ」があるか検索（そのユーザーがその投稿にいいねしているかどうかを調べる）
    favorite.destroy#そのオブジェを削除
    redirect_to request.referer #元のviewに戻ってきます。
  end
end
