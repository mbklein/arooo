class Vote < ActiveRecord::Base
  belongs_to :day
  has_one :voter, :class_name => 'Player'
  has_one :target :class_name => 'Player'
end
