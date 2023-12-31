class Like < ApplicationRecord
  belongs_to :post, class_name: 'Post'
  belongs_to :user, class_name: 'User'
  def update_post_likes_counter
    post.update(likes_counter: post.likes.count)
    post.likes.count
  end
end
