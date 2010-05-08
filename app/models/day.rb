class Day < ActiveRecord::Base
  belongs_to :game
  has_one :thread, :class_name => 'DayThread'
  has_many :votes, :order => 'seq'
  
  def reset!
    self.votes.each { |vote| vote.destroy }
    self.thread.update_attributes :last_post => nil, :last_page => nil
  end
  
  def update!
    votes = []
    thread.each_unread { |post| 
      post_id = post['post_id']
      voter = game.find_player(post['username'])
      cast = DateTime.strptime(post['post_timestamp'], '%m-%d-%Y %H:%M %p')
      text = post['quotable'].split(/\n|<br\/>/)
      text.each { |line|
        post_votes = line.scan(/^\s*(unvote|vote\s)\s*([A-Za-z0-9 ]+?)?\s*$/i)
        post_votes.each { |v|
          if voter == nil
            voter = game.add_player(Person.find_or_create_by_name(post['username']))
          end
          target = v.last.nil? ? nil : game.find_player(v.last)
          
          vote = Vote.create(
            :seq => self.votes.length, 
            :voter => voter, 
            :target => target, 
            :target_name => v.last, 
            :cast => cast,
            :source_post => post_id
          )
          self.votes << vote
        }
      }
    }
  end

end
