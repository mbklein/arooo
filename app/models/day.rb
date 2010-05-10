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
    thread.each_unread_page { |page|
      page_votes = page[:doc].search(self.game.server.xpath_to_vote).select { |b| b.text =~ /^(unvote|vote\s+(.+))/mi }.collect { |vote|
        voter = vote.search(self.game.server.xpath_vote_to_user).text
        voting_player = game.find_player(voter)
        post_id = vote.search(self.game.server.xpath_vote_to_post_id).text.sub(/^post/,'').to_i
        post_votes = vote.text.scan(/^(unvote|vote\s+(.+))/mi)
        post_votes.each { |vote|
          target = vote.last
          target_player = target.nil? ? nil : game.find_player(target)
          vote = Vote.create(
            :seq => self.votes.length,
            :voter => voting_player,
            :target => target_player,
            :target_name => target,
            :source_post => post_id
          )
          self.votes << vote
        }
      }
    }
  end

end
