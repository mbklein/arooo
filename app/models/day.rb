class Day < ActiveRecord::Base
  belongs_to :game
  has_one :thread, :class_name => 'DayThread'
  has_many :votes, :order => 'seq'
  
  def reset!
    self.votes.each { |vote| vote.destroy }
    self.update_attributes :last_post => nil, :last_page => nil
  end
  
end
