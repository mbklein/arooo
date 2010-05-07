class Person < ActiveRecord::Base
  has_many :nicknames
  has_many :moderated_games, :class_name => 'Game', :foreign_key => 'moderator_id'
  has_many :games, :through => :players
end
