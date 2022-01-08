class RelationshipsController < ApplicationController
  # before_action :authenticate_user!
  # def create
  #   follower = Relationship.new(follower_id: params[:user_id], followed_id: current_user.id)
  #   follower.save
  #   redirect_to request.referrer || root_path
  # end

  # def destroy
  #   # follower = current_user.relationships.find_by(follower_id: params[:user_id])
  #   follower = Relationship.find_by(follower_id: params[user_id], followed_id: current_user.id)
  #   follower.destroy
  #   redirect_to request.referrer || root_path
  # end
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
end
