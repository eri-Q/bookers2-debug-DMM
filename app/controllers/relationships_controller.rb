class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    follower = current_user.relationships.build(follower_id: params[:user_id])
    follower.save
    redirect_to request.referrer || root_path
  end

  def destroy
    follower = current_user.relationships.find_by(follower_id: params[:user_id])
    follower.destroy
    redirect_to request.referrer || root_path
  end
  def destroy
    following = current_user.relationships.find_by(follower_id: params[:user_id])
    following.destroy
    redirect_to request.referrer || root_path
  end
end
