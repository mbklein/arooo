class Game < ActiveRecord::Base
  has_many :players, :order => 'seq'
  has_many :days, :order => 'seq'
  belongs_to :moderator, :class_name => 'Person'
  belongs_to :server
end
