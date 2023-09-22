class Comment < ApplicationRecord
  belongs_to :post, class_name: 'Post'
  belongs_to :user, class_name: 'User'
  def update_post_comments_counter
    post.update(comments_counter: post.comments.count)
    post.comments.count
  end
end
