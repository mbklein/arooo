require 'forum_runner'

class ThreadLoadError < Exception; end
  
class DayThread < ActiveRecord::Base

belongs_to :day

def server
  self.day.game.server
end

def runner
  self.server.runner
end

def get_page(page = nil)
  if page.nil?
    page = self.last_page
  end
  result = self.runner.get_thread(self.topic_id, page, 50)
  if result['success']
    return result['data']
  else
    raise ThreadLoadError, result['message']
  end
end

def next_page
  self.get_page(self.last_page.to_i + 1)
end

def each_unread
  data = self.get_page
  if data['posts'].last['post_id'].to_i <= self.last_post.to_i
    return false
  end
  
  until data.nil?
    self.last_page = data['page']
    data['posts'].each { |post| 
      if post['post_id'].to_i > self.last_post.to_i
        yield(post)
        self.last_post = post['post_id'].to_i
      end
    }
    if (self.last_page.to_i * 50) >= data['total_posts']
      data = nil
    else
      data = self.get_page(self.last_page + 1)
    end
  end
  self.save
end

end
