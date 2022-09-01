class RelationshipsController < ApplicationController
  before_action :set_user, only: [:followings, :followers]

  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def followings
    @users = @user.followings
  end

  def followers
    @users = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  #def create
    #user = User.find(params[:user_id])
    #relationship = current_user.relationships.new(user_id: user.id)
    #relationship.save
    #redirect_to request.referer #元のviewに戻ってきます。
  #end

  #def destroy
    #user = User.find(params[:user_id])
    #relationship = current_user.relationship.find_by(user_id: user.id)
    #relationship.destroy
    #redirect_to request.referer #元のviewに戻ってきます。
  #end

end
