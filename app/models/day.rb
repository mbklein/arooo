class Day < ActiveRecord::Base
  belongs_to :game
  has_one :thread, :class_name => 'DayThread'
  has_many :votes, :order => 'seq'
end
