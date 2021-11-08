class AddBodyToTweets < ActiveRecord::Migration[6.1]
  def change
    add_column :tweets, :body, :text
  end
end
