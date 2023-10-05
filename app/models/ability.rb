# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == 'admin'
      can :manage, :all
    elsif user
      can :read, :all
      can :manage, Post, author_id: user.id
      can :manage, Comment, user_id: user.id
    end
  end
end