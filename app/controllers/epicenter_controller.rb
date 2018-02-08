class EpicenterController < ApplicationController
  
  before_action :set_user, only: [:show_user, :following, :followers]
  
  def all_users
    @users = User.order(name: :asc)
  end
  
  def following
   empty_users_array
    
    User.all.each do |user|
      if @user.following.include?(user.id)
        @users.push(user)
      end
    end
    
  end
  
  def followers
   empty_users_array
    
    User.all.each do |user|
      if user.following.include?(@user.id)
        @users.push(user)
      end
    end
  end
  
  def tag_tweets
    @tag = Tag.find(params[:id])
  end
  
  def feed
    @tweet = Tweet.new
    @following_tweets = []
    
    Tweet.all.each do |tweet|
      if current_user.id == tweet.user_id || current_user.following.include?(tweet.user_id)
        @following_tweets.push(tweet)
      end
    end
  end

  def show_user
    
  end

  def now_following
    current_user.following.push(params[:id].to_i)
    current_user.save
    
    redirect_to show_user_path(id: params[:id])
    
  end

  def unfollow
    current_user.following.delete(params[:id].to_i)
    current_user.save
    
    redirect_to show_user_path(id: params[:id])
  end
  
  private
  
  def empty_users_array
    @users = []
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
