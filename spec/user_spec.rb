require 'rails_helper'

RSpec.describe User, type: :Model do
  let(:user) { User.new(name: 'Munish', photo: 'www.newpics.com/png', bio: 'Last Human', posts_counter: 4) }
  before { user.save }

  it 'name should be present' do
    user.name = nil
    expect(user).to_not be_valid
  end
  it 'posts_counter must be an integer' do
    user.posts_counter = 'a'
    expect(user).to_not be_valid
  end
  it 'posts_counter should be >= to zero' do
    user.posts_counter = -1
    expect(user).to_not be_valid
  end
  describe '#recent_posts' do
    it 'should have correct number of posts' do
      Post.create(title: 'Post One', text: 'Content One', comments_counter: 0, likes_counter: 0, author_id: user.id)
      Post.create(title: 'Post Two', text: 'Content Two', comments_counter: 0, likes_counter: 0, author_id: user.id)
      Post.create(title: 'Post Three', text: 'Content Three', comments_counter: 0, likes_counter: 0, author_id: user.id)
      my_posts = user.recent_posts
      expect(my_posts.length).to eq(3)
    end
  end
end
