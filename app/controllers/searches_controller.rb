class SearchesController < ApplicationController
  before_action :authenticate_user!

  #下記コードにて検索フォームからの情報を受け取っています。
  #検索モデル→params[:range]
  #検索方法→params[:search]
  #検索ワード→params[:word]
  def search
    #以下サンプルより
    @model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'user'
			@records = User.search_for(@content, @method)
		else
			@records = Book.search_for(@content, @method)
		end

    #@range = params[:range]

   # if @range == "User" #if文を使い、検索モデルUserorBookで条件分岐させます。
     # @users = User.looks(params[:search], params[:word])
   # else
    #  @books = Book.looks(params[:search], params[:word])
      #検索方法params[:search]と、検索ワードparams[:word]を参照してデータを検索し、
      #1：インスタンス変数@usersにUserモデル内での検索結果を代入します。
      #2：インスタンス変数@booksにBookモデル内での検索結果を代入します。
   # end

  end

end
