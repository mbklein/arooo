class Day < ActiveRecord::Base
  belongs_to :game
  has_one :thread, :class_name => 'DayThread', :dependent => :destroy
  has_many :deaths, :class_name => 'Player', :foreign_key => 'death_day_id', :dependent => :nullify
  has_many :votes, :order => 'seq', :dependent => :destroy

  def players
    dead_players = self.game.days.collect { |day| day.seq < self.seq ? day.deaths : nil }.compact.flatten
    result = self.game.players - dead_players
  end
  
  def unresolved_votes
    self.votes.select { |v| not v.identified }
  end
  
  def to_lynch
    (self.players.length / 2) + 1
  end
  
  def tally
    lynch = false
    players = self.players
    record = []
    unvoted = players.dup
    self.votes.each { |v|
      if v.action == 'vote'
        target_line = record.find { |line| line[0] == v.target }
        if target_line.nil?
          target_line = [v.target,[]]
          record << target_line
        end
        
        target_line[1] << unvoted.delete(v.voter)
        if target_line[1].length >= self.to_lynch
          lynch = true
          break
        end
      else
        target_line = record.find { |line| line[1].include?(v.voter) }
        unvoted << target_line[1].delete(v.voter)
        if target_line[1].compact.empty?
          record.delete(target_line)
        end
      end
    }
    
    record = record.compact.sort { |a,b|
      vc = b[1].length <=> a[1].length
    }
    
    return {
      :seq => self.seq,
      :player_count => self.players.length,
      :to_lynch => self.to_lynch,
      :lynch => lynch,
      :record => record,
      :unvoted => unvoted
    }
  end
  
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
