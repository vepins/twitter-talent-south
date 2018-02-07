class AddLinkToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :link, :string
  end
end
