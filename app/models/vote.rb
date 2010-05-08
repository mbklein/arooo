class Vote < ActiveRecord::Base
  belongs_to :day
  belongs_to :voter,  :class_name => 'Player'
  belongs_to :target, :class_name => 'Player'
end
