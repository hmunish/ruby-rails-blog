require 'rails_helper'

RSpec.describe 'users#show page', type: :feature do
  before(:each) do
    @user1 = User.create(
      name: 'Munish',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Web developer from Malawi',
      posts_counter: 0
    )

    @user2 = User.create(
      name: 'Halai',
      photo: 'https://unsplash.com/photos/igX2deuD9lc',
      bio: 'Software Engineer.',
      posts_counter: 0
    )
    @posts = [
      Post.create(author: @user1, title: 'My test post one', text: 'this is first test post',
                  comments_counter: 0, likes_counter: 0),
      Post.create(author: @user1, title: 'My test post two', text: 'this is second test post',
                  comments_counter: 0, likes_counter: 0),
      Post.create(author: @user1, title: 'My test post three', text: 'this is third test post',
                  comments_counter: 0, likes_counter: 0)
    ]

    visit users_url
  end
  describe 'show page' do
    before(:each) do
      visit user_path(@user1)
    end

    it 'can see the user profile picture.' do
      expect(page).to have_css("img[src='#{@user1.photo}']")
    end

    it 'can see the user username' do
      expect(page).to have_content(@user1.name.to_s)
    end

    it 'I can see the number of posts the user has written.' do
      expect(page).to have_content("Number of posts: #{@user1.posts_counter}")
    end

    it 'I can see the user bio.' do
      expect(page).to have_content(@user1.bio.to_s)
    end

    it 'I can see the user first 3 posts.' do
      @user1.recent_posts.each do |post|
        expect(page).to have_content(post.text)
      end
    end

    it 'can see a button to view all user posts' do
      expect(page).to have_selector('button', text: 'See all posts')
    end
  end

  describe 'show page' do
    before(:each) do
      visit user_path(@user2)
    end

    it 'can see the user profile picture.' do
      expect(page).to have_css("img[src='#{@user2.photo}']")
    end

    it 'can see the user username' do
      expect(page).to have_content(@user2.name.to_s)
    end

    it 'I can see the number of posts the user has written.' do
      expect(page).to have_content("Number of posts: #{@user2.posts_counter}")
    end

    it 'I can see the user bio.' do
      expect(page).to have_content(@user2.bio.to_s)
    end

    it 'can see a button to view all user posts' do
      expect(page).to have_selector('button', text: 'See all posts')
    end
  end

  describe 'GET/posts/show' do
    it 'When clicked a user post, redirects me to that post show page' do
      visit user_path(@user1)
      post = @user1.recent_posts.first
      click_link(post.id)
      expect(page).to have_current_path(user_post_path(@user1, post))
    end
    it 'When I click to see all posts, redirects to the user posts index page.' do
      visit user_path(@user1)
      click_link 'See all posts'
      expect(page).to have_current_path(user_posts_path(@user1))
    end
  end
end
